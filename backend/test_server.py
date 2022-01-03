import server
import unittest

class TestServer(unittest.TestCase):
    
    def setup(self):
        self.app = server.app.get.test_client()
        self.app.testing = True
    
    def test_status_code(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()
    
        