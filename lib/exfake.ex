defmodule Exfake do
  @moduledoc """
  Documentation for `Exfake`.
  """

  alias Datasets.{Names, Phones, Lorem, Company, Xss}

  @doc """
  Generates first name.

  ## Examples

      iex> Exfake.gen_first_name()
      "Jake"
      iex> Exfake.gen_first_name()
      "Rosemary"
  """
  @spec gen_first_name :: String.t()
  def gen_first_name() do
    Enum.random(Names.first_names())
  end

  @doc """
  Generates last name.

  ## Examples

      iex> Exfake.gen_last_name()
      "Nitzsche"
      iex> Exfake.gen_last_name()
      "Adams"
  """
  @spec gen_last_name :: String.t()
  def gen_last_name() do
    Enum.random(Names.last_names())
  end

  @doc """
  Generates first name + last name combination.

  ## Examples

      iex> Exfake.gen_person()
      "Jake Nitzsche"
      iex> Exfake.gen_person()
      "Luciano Eichmann"
  """
  @spec gen_person :: String.t()
  def gen_person() do
    "#{gen_first_name()} #{gen_last_name()}"
  end

  @doc """
  Generates phone number which formatted randomly.

  ## Examples

      iex> Exfake.gen_phone_number()
      "684-126-0269"
      iex> Exfake.gen_phone_number()
      "1-319-098-3384 x06095"
  """
  @spec gen_phone_number :: String.t()
  def gen_phone_number() do
    Phones.formats()
    |> Enum.random()
    |> String.replace("#", fn _ -> Integer.to_string(Enum.random(0..9)) end)
  end

  @doc """
  Generates random latin word.

  ## Examples

      iex> Exfake.gen_word()
      "eveniet"
      iex> Exfake.gen_word()
      "magnam"
  """
  @spec gen_word :: String.t()
  def gen_word() do
    Enum.random(Lorem.latin_words())
  end

  @doc """
  Generates random lorem sentence with specified words count.
  Words count must be greater than 1.
  Default words count is 5.

  ## Examples

      iex> Exfake.gen_sentence()
      "Dolorum sed tempora quod quisquam."
      iex> Exfake.gen_sentece(2)
      "Libero vel."
  """
  @spec gen_sentence(pos_integer) :: String.t()
  def gen_sentence(count \\ 5) when count > 1 do
    beg = gen_word() |> String.capitalize()
    body = 1..(count - 1) |> Enum.map(fn _ -> gen_word() end) |> Enum.join(" ")

    "#{beg} #{body}."
  end

  @doc """
  Generates random lorem paragraph with specified sentence count and sentence words count which randoms between 2 and 5.
  Sentence count must be greater than 0.
  Default sentence count is 3.
  Default words count between 2 and 5.

  ## Examples

      iex> Exfake.gen_paragraphs()
      "Ut iure. Dicta officiis fugit sapiente consequuntur. Tenetur nisi."
      iex> Exfake.gen_paragraphs(3, 2)
      "Est deserunt. Non quae. Consectetur consequatur."
      iex> Exfake.gen_paragraphs(3, 2)
      "Aut non. Eos voluptas. Et libero asperiores. Fugiat esse suscipit. Magnam accusamus molestias aperiam."
  """
  @spec gen_paragraphs(pos_integer, pos_integer()) :: String.t()
  def gen_paragraphs(n \\ 3, limit \\ 5) when n > 0 do
    1..n |> Enum.map(fn _ -> gen_sentence(Enum.random(2..limit)) end) |> Enum.join(" ")
  end

  @doc """
  Generates a random company suffix.

  ## Examples

      iex> Exfake.gen_company_suffix()
      "Inc"
      iex> Exfake.gen_company_suffix()
      "LLC"
  """
  @spec gen_company_suffix() :: String.t()
  def gen_company_suffix() do
    Enum.random(Company.suffixes())
  end

  @doc """
  Generates a random company catch phrase.

  ## Examples

      iex> Exfake.gen_catch_phrase()
      "Re-engineered maximized productivity"
      iex> Exfake.gen_catch_phrase()
      "Right-sized hybrid complexity"
  """
  @spec gen_catch_phrase() :: String.t()
  def gen_catch_phrase() do
    Enum.map(Company.catch_phrase_words(), &Enum.random/1) |> Enum.join(" ")
  end

  @doc """
  Generates a random company BS goals.

  ## Examples

      iex> Exfake.gen_bs()
      "reintermediate granular niches"
      iex> Exfake.gen_bs()
      "unleash user-centric markets"
  """
  @spec gen_bs :: String.t()
  def gen_bs() do
    Enum.map(Company.bs_words(), &Enum.random/1) |> Enum.join(" ")
  end

  @doc """
  Generates a random company name.

  ## Examples

      iex> Exfake.gen_company_name()
      "Klein, Mueller and Windler"
      iex> Exfake.gen_company_name()
      "Zion Kerluke LLC"
      iex> Exfake.gen_company_name()
      "Legros-Yundt"
  """
  @spec gen_company_name :: String.t()
  def gen_company_name() do
    [
      "#{gen_person()} #{gen_company_suffix()}",
      "#{gen_last_name()}-#{gen_last_name()}",
      "#{gen_last_name()}, #{gen_last_name()} and #{gen_last_name()}"
    ]
    |> Enum.random()
  end

  @doc """
  Generates a random XSS string.

  ## Examples

      iex> Exfake.gen_xss_string()
      "<BODY BACKGROUND=\"javascript:alert('XSS')\">"
      iex> Exfake.gen_xss_string()
      "<A HREF=\"http://0102.0146.0007.00000223/\">XSS</A>"
  """
  @spec gen_xss_string :: String.t()
  def gen_xss_string() do
    Enum.random(Xss.data())
  end

  @doc """
  Generates a random XSS file.

  ## Examples

      iex> Exfake.gen_xss_file()
      "<TABLE><TD BACKGROUND=\"javascript:alert('XSS')\">.txt"
      iex> Exfake.gen_xss_file()
      "<IMG SRC=\"javascript:alert('XSS');\">.txt"
  """
  @spec gen_xss_file :: String.t()
  def gen_xss_file() do
    Enum.random(Xss.files())
  end
end
