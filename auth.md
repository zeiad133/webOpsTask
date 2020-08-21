**Auth**
----


----
  Sign UP.

**Sign Up**
* **URL**

  api/sign_up

* **Method:**

  `Post`
  

* **Data Params**

  `user{
      "email":"user@gmail.com",
      "password":"11223344",
      "name": "zeiad",
      "image": File
  }

* **Success Response:**

  * **Code:** 200 <br />




----
  Log IN.

**Log In**
* **URL**

  api/users/user_token

* **Method:**

  `Patch`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

   `auth{
      "email":"user@gmail.com",
      "password":11223344
  }

* **Success Response:**

  * **Code:** 200 <br />
  
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />


