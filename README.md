##GO-JEK Web apps
(GO-SCHOLAR final project)

#User (customer/driver) can create user account
* Run active record validation
* Run cross service validation (synchronous)
* Register Go-Pay service (synchronous)

#User (customer/driver) can login
* Create customer session

#User (customer/driver) can view profile
* View detail of current user (from session)

#User (customer/driver) can edit profile
* Run active record validation
* Run cross service validation (synchronous)

#Customer top-up Go-Pay
* Update Go-Pay amount in Go-Pay service (synchronous)
* Update Go-Pay amount in database

#User can view Go-Pay
* View Go-Pay from database

#Customer can create Order
* Run active record validation
* If using Go-Pay, validate with customer Go-Pay
* Save order with Initialized status
* Send order to Driver (asynchronous)
* Wait for message from Driver (asynchronous)
* If driver is found, update order to Driver Assigned, update order’s driver
* If driver is not found, update order to Cancelled by System
* If no message is received for more than 2 minutes after order initialization, update status to Cancelled by System, send cancellation message to Driver
* If order is cancelled and customer using Go-Pay, Go-Pay balance is restored to previous amount

#Customer can see order history
* See current user’s orders
* View order detail
* See driver’s name, license, phone

#Driver can see job history
* See current user’s orders
* View detail

Customer's side: https://github.com/ajengs/gojek
Driver's side: https://github.com/ajengs/gojek-for-driver
Go-Pay Service: https://github.com/ajengs/gopay-service