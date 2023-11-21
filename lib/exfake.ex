defmodule Exfake do
  @moduledoc """
  Documentation for `Exfake`.
  """

  alias Datasets.{Names, Phones, Lorem, Company, Xss, Internet}

  @doc """
  Generates first name.

  ## Examples

      iex> Exfake.first_name()
      "Jake"
      iex> Exfake.first_name()
      "Rosemary"
  """
  @spec first_name :: String.t()
  def first_name() do
    Enum.random(Names.first_names())
  end

  @doc """
  Generates last name.

  ## Examples

      iex> Exfake.last_name()
      "Nitzsche"
      iex> Exfake.last_name()
      "Adams"
  """
  @spec last_name :: String.t()
  def last_name() do
    Enum.random(Names.last_names())
  end

  @doc """
  Generates first name + last name combination.

  ## Examples

      iex> Exfake.person()
      "Jake Nitzsche"
      iex> Exfake.person()
      "Luciano Eichmann"
  """
  @spec person :: String.t()
  def person() do
    "#{first_name()} #{last_name()}"
  end

  @doc """
  Generates phone number which formatted randomly.

  ## Examples

      iex> Exfake.phone_number()
      "684-126-0269"
      iex> Exfake.phone_number()
      "1-319-098-3384 x06095"
  """
  @spec phone_number :: String.t()
  def phone_number() do
    Phones.formats()
    |> Enum.random()
    |> String.replace("#", fn _ -> Integer.to_string(Enum.random(0..9)) end)
  end

  @doc """
  Generates random english word.

  ## Examples

      iex> Exfake.word()
      "burn"
      iex> Exfake.word()
      "language"
  """
  @spec word :: String.t()
  def word() do
    Enum.random(Lorem.en_words())
  end

  @doc """
  Generates random english sentence with specified words count.
  Words count must be greater than 1.
  Default words count is 5.

  ## Examples

      iex> Exfake.sentence()
      "Judge taste page porter harmony."
      iex> Exfake.sentece(3)
      "Event minute view."
  """
  @spec sentence(pos_integer) :: String.t()
  def sentence(count \\ 5) when count > 1 do
    beg = word() |> String.capitalize()
    body = 1..(count - 1) |> Enum.map_join(" ", fn _ -> word() end)
    "#{beg} #{body}."
  end

  @doc """
  Generates random lorem paragraph with specified sentence count and sentence words count which randoms between 2 and 5.
  Sentence count must be greater than 0.
  Default sentence count is 3.
  Default words count between 2 and 5.

  ## Examples

      iex> Exfake.paragraphs()
      "Statement waste mind. Verse sugar answer adjustment behavior. Soup attempt."
      iex> Exfake.paragraphs(3, 2)
      "Smoke ink. Cry day. Company stop."
      iex> Exfake.paragraphs(3, 2)
      "Nation wind. Sea stone. Minute comparison."
  """
  @spec paragraphs(pos_integer, pos_integer()) :: String.t()
  def paragraphs(n \\ 3, limit \\ 5) when n > 0 do
    1..n |> Enum.map_join(" ", fn _ -> sentence(Enum.random(2..limit)) end)
  end

  @doc """
  Generates a random company suffix.

  ## Examples

      iex> Exfake.company_suffix()
      "Inc"
      iex> Exfake.company_suffix()
      "LLC"
  """
  @spec company_suffix() :: String.t()
  def company_suffix() do
    Enum.random(Company.suffixes())
  end

  @doc """
  Generates a random company catch phrase.

  ## Examples

      iex> Exfake.catch_phrase()
      "Re-engineered maximized productivity"
      iex> Exfake.catch_phrase()
      "Right-sized hybrid complexity"
  """
  @spec catch_phrase() :: String.t()
  def catch_phrase() do
    Enum.map_join(Company.catch_phrase_words(), " ", &Enum.random/1)
  end

  @doc """
  Generates a random company BS goals.

  ## Examples

      iex> Exfake.bs()
      "reintermediate granular niches"
      iex> Exfake.bs()
      "unleash user-centric markets"
  """
  @spec bs :: String.t()
  def bs() do
    Enum.map_join(Company.bs_words(), " ", &Enum.random/1)
  end

  @doc """
  Generates a random company name.

  ## Examples

      iex> Exfake.company_name()
      "Klein, Mueller and Windler"
      iex> Exfake.company_name()
      "Zion Kerluke LLC"
      iex> Exfake.company_name()
      "Legros-Yundt"
  """
  @spec company_name :: String.t()
  def company_name() do
    [
      "#{person()} #{company_suffix()}",
      "#{last_name()}-#{last_name()}",
      "#{last_name()}, #{last_name()} and #{last_name()}"
    ]
    |> Enum.random()
  end

  @doc """
  Generates a random XSS string.

  ## Examples

      iex> Exfake.xss_string()
      "<BODY BACKGROUND=\"javascript:alert('XSS')\">"
      iex> Exfake.xss_string()
      "<A HREF=\"http://0102.0146.0007.00000223/\">XSS</A>"
  """
  @spec xss_string :: String.t()
  def xss_string() do
    Enum.random(Xss.data())
  end

  @doc """
  Generates a random XSS file.

  ## Examples

      iex> Exfake.xss_file()
      "<TABLE><TD BACKGROUND=\"javascript:alert('XSS')\">.txt"
      iex> Exfake.xss_file()
      "<IMG SRC=\"javascript:alert('XSS');\">.txt"
  """
  @spec xss_file :: String.t()
  def xss_file() do
    Enum.random(Xss.files())
  end

  @doc """
  Generates a random IPv4 address.

  ## Examples

      iex> Exfake.ipv4()
      "145.77.91.223"
      iex> Exfake.ipv4()
      "17.94.49.5"
  """
  @spec ipv4 :: String.t()
  def ipv4() do
    head = [Enum.random(1..255)]
    body = 1..3 |> Enum.map(fn _ -> Enum.random(0..255) end)
    (head ++ body) |> Enum.join(".")
  end

  @doc """
  Generates a random email.

  ## Examples

      iex> Exfake.email()
      "dallas@gmail.com"
      iex> Exfake.email()
      "miller@hotmail.com"
  """
  @spec email :: String.t()
  def email() do
    "#{String.downcase(first_name())}@#{Enum.random(Internet.free_domains())}"
  end

  @doc """
  Generates a random domain.

  ## Examples

      iex> Exfake.domain()
      "www.laboriosam.me"
      iex> Exfake.email()
      "www.nihil.biz"
  """
  @spec domain :: String.t()
  def domain() do
    "www.#{String.downcase(word())}.#{Enum.random(Internet.suffixes())}"
  end

  @doc """
  Generates a random USA zip code.

  ## Examples

      iex> Exfake.zip_code()
      "32107-6766"
      iex> Exfake.zip_code()
      "9152"
  """
  @spec zip_code :: String.t()
  def zip_code() do
    without_dash = 0..3 |> Enum.map_join(fn _ -> Enum.random(0..9) end)
    with_dash = "#{without_dash}-#{Enum.map_join(0..3, fn _ -> Enum.random(0..9) end)}"

    [with_dash, without_dash] |> Enum.random()
  end
end
