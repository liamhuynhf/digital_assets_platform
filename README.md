# Digital Assets Platform

I have added a script to create three accounts, each corresponding to a specific role: admin, creator, and customer.
To test with a specific role, please open a new incognito tab (as I didn’t have enough time to implement the logout feature) and log in via /login using the credentials defined in the seeds.exs file.

Additionally, I’ve included a sample assets JSON file for importing at /priv/sample_assets.json.

## Features

### For Creators
- Import assets via JSON file
- Upload digital assets with title, description, URL, and pricing

### For Customers
- Browse available assets
- Single and bulk purchase options
- Download purchased assets
- View purchase history

### For Admins
- View creator earnings via API

## Technical Stack

- **Framework**: Phoenix/Elixir
- **Database**: PostgreSQL
- **Authentication**: Custom session-based auth
- **File Storage**: URL-based asset storage

## Getting Started

### Prerequisites

- Elixir 1.14 
- Erlang/OTP 27
- Phoenix 1.7
- PostgreSQL 13

### Installation

1. Clone the repository:
```bash
git clone https://github.com/liamhuynhf/digital_assets_platform.git
```

2. Install dependencies:
```bash
mix deps.get
```

3. Setup database:
```bash
mix ecto.setup
```

4. Start Phoenix server:
```bash
mix phx.server
```

Visit [`localhost:4000/login`](http://localhost:4000/login) in your browser.

## Usage

### Creator Guide

1. **Asset Import**
   - Format your assets in JSON:
   ```json
     [
       {
         "title": "Asset Title",
         "description": "Asset Description",
         "file_url": "https://example.com/asset.zip",
         "price": 29.99
       }
     ]
   ```
   - Navigate to `/import`
   - Upload JSON file

### Customer Guide

1. **Purchasing Assets**
   - Browse assets at `/assets`
   - Select individual or multiple assets
   - Complete purchase
   - View purchase history via `/my-purchases` and can download them

### Admin Guide

1. **View Creator Earnings via API**
   - API Endpoint: `GET /api/admin/creator_earnings`
   - Requires admin authentication
   - Returns earnings data in JSON format

## API Documentation

#### Get Creator Earnings
```
GET /api/admin/creator_earnings
Authorization: Bearer <token>
```

## Role-Based Access

- **Creators**: Access to import functionality
- **Customers**: Access to purchase and download features
- **Admins**: Access to earnings API and platform management

