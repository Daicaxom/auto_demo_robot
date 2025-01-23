import mysql.connector
from datetime import datetime, timedelta
from ..Config.config_manager import ConfigManager

class DatabaseVerificationHelper:
    def __init__(self):
        self.config_manager = ConfigManager()
        
    def _get_db_connection(self):
        """Create database connection using config"""
        try:
            return mysql.connector.connect(**self.config_manager.get_db_config())
        except mysql.connector.Error as err:
            raise Exception(f"Failed to connect to database: {err}")

    def get_verification_code(self, email):
        """Get verification code from database"""
        try:
            conn = self._get_db_connection()
            cursor = conn.cursor()
            
            query = """
                SELECT code, created_at 
                FROM verification_codes 
                WHERE email = %s 
                  AND created_at >= %s 
                  AND used = FALSE
                ORDER BY created_at DESC 
                LIMIT 1
            """
            
            time_threshold = datetime.now() - timedelta(minutes=15)
            cursor.execute(query, (email, time_threshold))
            
            result = cursor.fetchone()
            if result:
                code, created_at = result
                return {
                    'code': code,
                    'created_at': created_at
                }
            return None
            
        except Exception as e:
            raise Exception(f"Failed to get verification code: {str(e)}")
        finally:
            if 'conn' in locals():
                cursor.close()
                conn.close() 