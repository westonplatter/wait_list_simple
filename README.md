## Wait List Simple


Example Use Case
----------------

Simple one page app (without styling) demonstrating a wait list.

User 1 signs up for the wait list with email `user1@example.com`. They are in position #1.

User 2 signs up with `user2@example.com`. They're in position #2.

User 3 signs up with `user3@example.com`. They're in position #3.

User 3 tries to game the system by referral themself and signing up with a
derivative of their email, `user3+101@example.com`. The system inteprets their
email as `user3@example.com` and makes not adjustment to User 3's accont. The
system responds with text on the page stating that User 3 is in position #3.

User 2 referrals User 4 to sign up via their referral link. When User 4 signs
up with `user4@example.com`, User 4 is position #4, and User 2 is bumped up to
position #1.


What changes would you make to your code, if any, to ensure that your solution could handle 1,000,000+ users?
-------------------------------------------------------------------------------------------------------------

1. Move the position adjustment operation to a background job

2. Shrink email field number of characters from 255 to 50 or so (index becomes more efficient)


What architecture would you put in place to handle large fluctuations in traffic?
---------------------------------------------------------------------------------

Set up a front end load balancer proxy HTTP requests to app servers connected
to a DB server. This allows one to dynamically increase or decrease the number
of app servers.
