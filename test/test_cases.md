Test case descriptions
1. Creator Features
1.1 Asset Import
- Successfully import valid JSON file with multiple assets
- Reject JSON with missing required fields

2. Customer Features
2.1 Asset Purchase
- Single asset purchase success
- Multiple assets bulk purchase
- Purchase history display

2.2 Asset Access
- List all available assets
- Display asset details (title, description, price)

3. Authentication & Authorization
3.1 User Authentication
- Successful login with valid account
- Reject invalid account

3.2 Role-based Access
- Creator access to import feature
- Customer access to purchase features
- Proper role validation
- Redirect access

4. Admin API
4.1 Creator Earnings API
- Get all creators' earnings
- Proper JSON response format