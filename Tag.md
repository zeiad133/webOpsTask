**Tags**
----


----
  Add a Tag to Post.

**Add Tag**
* **URL**

  api/tags

* **Method:**

  `Post`
  

* **Data Params**

  `tag{
      "description":"comment",
      "post_id":"1",
  }

* **Success Response:**

  * **Code:** 200 <br />

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`



----
  Update Tag.

**Update Tag**
* **URL**

  api/tags/:id

* **Method:**

  `Patch`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

   `tag{
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
  Delete Tag.

**Delete Tag**
* **URL**

  api/tags/:id

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



