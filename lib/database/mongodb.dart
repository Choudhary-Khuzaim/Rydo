import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';

class MongoDatabase {
  // -------------------------------------------------------------------------
  // STEP 1: Enter your MongoDB credentials here.
  // -------------------------------------------------------------------------
  static const String _username = "Khuzaim";
  static const String _password = "khuzaim09"; // CHANGE THIS!
  static const String _clusterAddress = "rydo.dcyiyrr.mongodb.net";
  // -------------------------------------------------------------------------

  static Db? _db;
  static DbCollection? _userCollection;
  static Map<String, dynamic>? currentUser;

  static Future<String?> connect() async {
    if (_db != null && _db!.state == State.OPEN) return null;

    if (_password == "your_real_password_here" || _password.contains("*")) {
      return "Please open lib/database/mongodb.dart and enter your actual password.";
    }

    // Auto-encode credentials to handle special characters like @, :, #
    final String encodedUser = Uri.encodeComponent(_username);
    final String encodedPass = Uri.encodeComponent(_password);

    // Construct the connection string safely
    final String connectionString =
        "mongodb+srv://$encodedUser:$encodedPass@$_clusterAddress/rydo?authSource=admin&tls=true";

    try {
      log("Attempting to connect to: $_clusterAddress");
      _db = await Db.create(connectionString);
      await _db!.open();
      _userCollection = _db!.collection('users');
      log("Successfully connected to MongoDB");
      return null;
    } catch (e) {
      log("DATABASE CONNECTION ERROR: $e");
      _db = null;
      _userCollection = null;
      return e.toString();
    }
  }

  static Future<String?> insert(Map<String, dynamic> data) async {
    try {
      if (_db == null || _db!.state != State.OPEN) {
        log("Database not connected, attempting to connect...");
        var connectError = await connect();
        if (connectError != null) return connectError;
      }

      if (_db == null || _db!.state != State.OPEN) {
        return "Database connection failed. Check your internet or password.";
      }

      var result = await _userCollection!.insertOne(data);
      if (result.isSuccess) {
        log("Data inserted successfully");
        return null; // Success
      } else {
        String error = result.writeError?.errmsg ?? "Unknown database error";
        log("Data insertion failed: $error");
        return error;
      }
    } catch (e) {
      log("Insert exception: $e");
      return e.toString();
    }
  }

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      if (_db == null || _db!.state != State.OPEN) {
        log("Database not connected, attempting to connect...");
        var connectError = await connect();
        if (connectError != null) {
          log("Connection error during login: $connectError");
          return null;
        }
      }

      final user = await _userCollection!.findOne({
        "email": email,
        "password": password,
      });

      if (user != null) {
        log("Login successful for: $email");
        return user;
      } else {
        log("Login failed: User not found or incorrect password");
        return null;
      }
    } catch (e) {
      log("Login exception: $e");
      return null;
    }
  }

  static Future<String?> updateProfile(
    ObjectId id,
    String name,
    String address,
  ) async {
    try {
      if (_db == null || _db!.state != State.OPEN) {
        var connectError = await connect();
        if (connectError != null) return connectError;
      }

      var result = await _userCollection!.updateOne(
        where.eq('_id', id),
        modify.set('name', name).set('address', address),
      );

      if (result.isSuccess) {
        // Update local session data
        if (currentUser != null) {
          currentUser!["name"] = name;
          currentUser!["address"] = address;
        }
        log("Profile updated successfully");
        return null;
      } else {
        return result.writeError?.errmsg ?? "Update failed";
      }
    } catch (e) {
      log("Update profile exception: $e");
      return e.toString();
    }
  }

  static void logout() {
    currentUser = null;
    log("User logged out");
  }

  static Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      _userCollection = null;
    }
  }
}
