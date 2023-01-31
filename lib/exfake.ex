defmodule Exfake do
  @moduledoc """
  Documentation for `Exfake`.
  """

  alias Datasets.{Names, Phones, Lorem}

  @doc """
  Generates first name.
  """
  @spec first_name :: String.t()
  def first_name() do
    Enum.random(Names.first_names())
  end

  @doc """
  Generates last name.
  """
  @spec last_name :: String.t()
  def last_name() do
    Enum.random(Names.last_names())
  end

  @doc """
  Generates first name + last name combination.
  """
  @spec person :: String.t()
  def person() do
    "#{first_name()} #{last_name()}"
  end

  @doc """
  Generates phone number which formatted randomly.
  """
  @spec phone_number :: String.t()
  def phone_number() do
    Phones.formats()
    |> Enum.random()
    |> String.replace("#", fn _ -> Integer.to_string(Enum.random(0..9)) end)
  end

  @doc """
  Generates random latin word.
  """
  @spec word :: String.t()
  def word() do
    Enum.random(Lorem.latin_words())
  end

  @doc """
  Generates random lorem sentence with specified words count.
  Words count must be greater than 2.
  Default words count is 5.
  """
  @spec sentence(pos_integer) :: String.t()
  def sentence(count \\ 5) when count > 2 do
    beg = word() |> String.capitalize()
    body = 1..count |> Enum.map(fn _ -> word() end) |> Enum.join(" ")

    "#{beg} #{body}."
  end

  @doc """
  Generates random lorem paragraph with specified sentence count.
  Sentence count must be greater than 0.
  Default sentence count is 3.
  """
  @spec paragraph(pos_integer) :: String.t()
  def paragraph(n \\ 3) when n > 0 do
    1..n |> Enum.map(fn _ -> sentence() end) |> Enum.join(" ")
  end
end
