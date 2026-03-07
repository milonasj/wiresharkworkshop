from http.server import HTTPServer, BaseHTTPRequestHandler

class LabHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        # We are "Setting" a cookie in the response!
        self.send_header('Set-Cookie', 'LabSession=WiresharksAndMinnows')
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"<h1>Local Weather Station</h1><p>Status: NO MORE SNOW!</p>")

httpd = HTTPServer(('0.0.0.0', 8080), LabHandler)
print("Weather Lab running on port 8080...")
httpd.serve_forever()
