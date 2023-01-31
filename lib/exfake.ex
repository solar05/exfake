defmodule Exfake do
  @moduledoc """
  Documentation for `Exfake`.
  """

  alias Datasets.{Names, Phones}

  @doc """
  Generates first name.
  """
  @spec first_name :: String.t()
  def first_name do
    Enum.random(Names.first_names())
  end

  @doc """
  Generates last name.
  """
  @spec last_name :: String.t()
  def last_name do
    Enum.random(Names.last_names())
  end

  @doc """
  Generates first name + last name combination.
  """
  @spec person :: String.t()
  def person do
    "#{first_name()} #{last_name()}"
  end

  @doc """
  Generates phone number which formatted randomly.
  """
  @spec phone_number :: String.t()
  def phone_number do
    Phones.formats()
    |> Enum.random()
    |> String.replace("#", fn _ -> Integer.to_string(Enum.random(0..9)) end)
  end
end
