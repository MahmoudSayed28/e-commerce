import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static late Supabase _supabase;
  static setUpSupabase() async {
    _supabase = await Supabase.initialize(
      url: 'https://uvqdcqercosnpmxfdziu.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2cWRjcWVyY29zbnBteGZkeml1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM2NjQyMDEsImV4cCI6MjA2OTI0MDIwMX0.SqDftmwNpeCpmp5i75zNUJWY8xDYK_Dm1E3Bmc0O-84',
    );
  }
}
