**Show User**
----
  Returns json data about a single user.

* **URL**

  api/posts/:id

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

  None

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{
        "id": 1,
        "title": "lolqqq",
        "body": "11223344",
        "tags": [
            {
                "id": 1,
                "description": "hobaaa",
                "created_at": "2020-08-21T23:31:30.000+02:00",
                "updated_at": "2020-08-21T23:31:30.000+02:00",
                "post_id": 1
            }
        ],
        "comments": [
            {
                "id": 1,
                "description": "testaa",
                "created_at": "2020-08-21T23:31:30.000+02:00",
                "updated_at": "2020-08-21T23:31:30.000+02:00",
                "post_id": 1,
                "user_id": 8
            }
        ]
    }`
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />

  OR

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`

* **Sample Call:**

  ```javascript
    $.ajax({
      url: "/users/1",
      dataType: "json",
      type : "GET",
      success : function(r) {
        console.log(r);
      }
    });
  ```