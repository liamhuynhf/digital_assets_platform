# Script for populating the database. You can run it as:
#   mix run priv/repo/seeds.exs

alias DigitalAssets.Accounts.User
alias DigitalAssets.Repo

# Define default users
default_users = [
  %{
    email: "admin@gmail.com",
    name: "Admin",
    role: "admin",
    password: "admin"
  },
  %{
    email: "creator@gmail.com",
    name: "Creator",
    role: "creator",
    password: "creator"
  },
  %{
    email: "customer@gmail.com",
    name: "Customer",
    role: "customer",
    password: "customer"
  }
]

# Create users if they don't exist
Enum.each(default_users, fn user_params ->
  # Check if user already exists
  case Repo.get_by(User, email: user_params.email) do
    nil ->
      %User{}
      |> User.changeset(user_params)
      |> Repo.insert!()

      Mix.shell().info("Created #{user_params.role} user: #{user_params.email}")

    _user ->
      Mix.shell().info("User #{user_params.email} already exists, skipping")
  end
end)
