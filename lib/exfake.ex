defmodule Exfake do
  @moduledoc """
  Documentation for `Exfake`.
  """

  alias Datasets.{Names, Phones, Lorem, Company, Xss, Internet, Addresses}

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

  @doc """
  Generates a random IPv4 address.

  ## Examples

      iex> Exfake.gen_ipv4()
      "145.77.91.223"
      iex> Exfake.gen_ipv4()
      "17.94.49.5"
  """
  @spec gen_ipv4 :: String.t()
  def gen_ipv4() do
    head = [Enum.random(1..255)]
    body = 1..3 |> Enum.map(fn _ -> Enum.random(0..255) end)
    (head ++ body) |> Enum.join(".")
  end

  @doc """
  Generates a random email.

  ## Examples

      iex> Exfake.gen_email()
      "dallas@gmail.com"
      iex> Exfake.gen_email()
      "miller@hotmail.com"
  """
  @spec gen_email :: String.t()
  def gen_email() do
    "#{String.downcase(gen_first_name())}@#{Enum.random(Internet.free_domains())}"
  end

  @doc """
  Generates a random domain.

  ## Examples

      iex> Exfake.gen_domain()
      "www.laboriosam.me"
      iex> Exfake.gen_email()
      "www.nihil.biz"
  """
  @spec gen_domain :: String.t()
  def gen_domain() do
    "www.#{String.downcase(gen_word())}.#{Enum.random(Internet.suffixes())}"
  end

  @doc """
  Generates a random USA zip code.

  ## Examples

      iex> Exfake.gen_zip_code()
      "32107-6766"
      iex> Exfake.gen_zip_code()
      "9152"
  """
  @spec gen_zip_code :: String.t()
  def gen_zip_code() do
    without_dash = 0..3 |> Enum.map(fn _ -> Enum.random(0..9) end) |> Enum.join()
    with_dash = "#{without_dash}-#{Enum.map(0..3, fn _ -> Enum.random(0..9) end) |> Enum.join()}"

    [with_dash, without_dash] |> Enum.random()
  end

  @doc """
  Generates a random USA state.

  ## Examples

      iex> Exfake.gen_us_state()
      "South Dakota"
      iex> Exfake.gen_us_state()
      "Kentucky"
  """
  @spec gen_us_state :: String.t()
  def gen_us_state() do
    Enum.random(Addresses.us_states())
  end

  @doc """
  Generates a random USA state abbreviation.

  ## Examples

      iex> Exfake.gen_us_state_abbr()
      "OK"
      iex> Exfake.gen_us_state_abbr()
      "GU"
  """
  @spec gen_us_state_abbr :: String.t()
  def gen_us_state_abbr() do
    Enum.random(Addresses.us_state_abbrs())
  end

  @doc """
  Generates a random city prefix, like North.

  ## Examples

      iex> Exfake.gen_city_prefix()
      "West"
      iex> Exfake.gen_city_prefix()
      "Port"
  """
  @spec gen_city_prefix :: String.t()
  def gen_city_prefix() do
    Enum.random(Addresses.city_prefixes())
  end

  @doc """
  Generates a random city suffix, like town.

  ## Examples

      iex> Exfake.gen_city_suffix()
      "view"
      iex> Exfake.gen_city_suffix()
      "bury"
  """
  @spec gen_city_suffix :: String.t()
  def gen_city_suffix() do
    Enum.random(Addresses.city_suffixes())
  end

  @doc """
  Generates a random city name.

  ## Examples

      iex> Exfake.gen_city()
      "South Trantow"
      iex> Exfake.gen_city()
      "Carliestad"
      iex> Exfake.gen_city()
      "West Abbigailfort"
  """
  @spec gen_city :: String.t()
  def gen_city() do
    first_name = gen_first_name()
    last_name = gen_last_name()
    prefix = gen_city_prefix()
    suffix = gen_city_suffix()

    [
      "#{prefix} #{first_name}#{suffix}",
      "#{prefix} #{first_name}",
      "#{prefix} #{last_name}",
      "#{last_name}#{suffix}",
      "#{first_name}#{suffix}"
    ]
    |> Enum.random()
  end

  @doc """
  Generates a random street suffix, like Avenue.

  ## Examples

      iex> Exfake.gen_street_suffix()
      "Road"
      iex> Exfake.gen_street_suffix()
      "Burg"
  """
  @spec gen_street_suffix :: String.t()
  def gen_street_suffix() do
    Enum.random(Addresses.street_suffixes())
  end

  @doc """
  Generates a random street name.

  ## Examples

      iex> Exfake.gen_street_name()
      "Carson Garden"
      iex> Exfake.gen_street_name()
      "Cornelius Pine"
  """
  @spec gen_street_name :: String.t()
  def gen_street_name() do
    suffix = gen_street_suffix()

    [
      "#{gen_first_name()} #{suffix}",
      "#{gen_last_name()} #{suffix}"
    ]
    |> Enum.random()
  end

  @doc """
  Generates a random secondary part of an address.

  ## Examples

      iex> Exfake.gen_secondary_address()
      "Apt. 7007 Suite 9896"
  """
  @spec gen_secondary_address :: String.t()
  def gen_secondary_address() do
    first_nums = 0..3 |> Enum.map(fn _ -> Enum.random(0..9) end) |> Enum.join()
    second_nums = 0..3 |> Enum.map(fn _ -> Enum.random(0..9) end) |> Enum.join()

    "Apt. #{first_nums} Suite #{second_nums}"
  end

  @doc """
  Generates a random address.
  If with_secondary is true the address will include a secondary part.

  ## Examples

      iex> Exfake.gen_street_address()
      "72823 7652 979"
      iex> Exfake.gen_street_address()
      "66320 7395 864"
      iex> Exfake.gen_street_address(true)
      "87648 6785 762 Apt. 1378 Suite 6759"
      iex> Exfake.gen_street_address(true)
      "59829 5347 642 Apt. 1732 Suite 4742"
  """
  @spec gen_street_address(boolean) :: String.t()
  def gen_street_address(with_secondary \\ false) do
    first_part =
      [
        Enum.random(10000..99999),
        Enum.random(1000..9999),
        Enum.random(100..999)
      ]
      |> Enum.join(" ")

    if with_secondary do
      "#{first_part} #{gen_secondary_address()}"
    else
      first_part
    end
  end
end
