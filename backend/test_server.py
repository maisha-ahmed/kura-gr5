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