**Comments**
----


----
  Add a Comment to Post.

**Add Comment**
* **URL**

  api/comments

* **Method:**

  `Post`
  

   **Required:**
 
   `id=[integer]`

* **Data Params**

  `comment{
      "description":"comment",
      "post_id":"1",
  }

* **Success Response:**

  * **Code:** 200 <br />

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`



----
  Update Comment.

**Update Comment**
* **URL**

  api/comments/:id

* **Method:**

  `Patch`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

   `comment{
      "description":"update",
  }

* **Success Response:**

  * **Code:** 200 <br />
  
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />

  OR

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`


----
  Delete Comment.

**Delete Comment**
* **URL**

  api/comments/:id

* **Method:**

  `Delete`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

* **Success Response:**

  * **Code:** 200 <br />
  
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />

  OR

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`



