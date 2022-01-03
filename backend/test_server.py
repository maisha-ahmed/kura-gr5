<<<<<<< HEAD
import server_app
import unittest

class TestServer(unittest.TestCase):
    
    def setup(self):
        self.app = server_app.app.get.test_client()
        self.app.testing = True
    
    def test_status_code(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()
    
        
=======
import server
import unittest

class Testserver(unittest.TestCase):

    def setUp(self):
        self.app = server.app.test_client()
        self.app.testing = True

    def test_status_code(self):
        response = self.app.get('/getAllOrders')
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()
>>>>>>> 8375a39f91fd30f1b933b174dcbaf46670769420
