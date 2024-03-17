from locust import HttpUser, task, between

class MyUser(HttpUser):
    wait_time = between(1, 3)

    @task
    def submit_json(self):
        payload = {"name": "John", "email": "john@example.com"}
        headers = {"Content-Type": "application/json"}
        self.client.post("/submit-json", json=payload, headers=headers)
    
    @task
    def submit_form(self):
        payload = {"name": "John", "email": "john@example.com"}
        response = self.client.post("/submit-data", data=payload)

        #Content-Type header is not necessary because requests.post will automatically use application/x-www-form-urlencoded for form data. Therefore, headers are removed.

