defmodule ChinguCentral.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false

  alias ChinguCentral.Accounts.User

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    user_changeset(user, %{})
  end

  def user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :name, :password])
    |> validate_required([:username, :email, :name, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> user_changeset(attrs)
    |> put_change(:encrypted_password, hashed_password(changeset.params["password"]))
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
