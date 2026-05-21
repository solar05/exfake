defmodule ExfakeTest do
  use ExUnit.Case

  describe "first_name/0" do
    test "returns a non-empty string" do
      name = Exfake.first_name()
      assert is_binary(name)
      assert String.length(name) > 0
    end
  end

  describe "last_name/0" do
    test "returns a non-empty string" do
      name = Exfake.last_name()
      assert is_binary(name)
      assert String.length(name) > 0
    end
  end

  describe "person/0" do
    test "returns two words separated by a space" do
      assert Exfake.person() =~ ~r/^\S+ \S+$/
    end
  end

  describe "phone_number/0" do
    test "returns a string containing digits" do
      assert Exfake.phone_number() =~ ~r/\d/
    end
  end

  describe "word/0" do
    test "returns a non-empty lowercase string" do
      word = Exfake.word()
      assert is_binary(word)
      assert String.length(word) > 0
      assert word == String.downcase(word)
    end
  end

  describe "sentence/1" do
    test "is capitalized and ends with a period" do
      s = Exfake.sentence()
      assert String.ends_with?(s, ".")
      assert s =~ ~r/^[A-Z]/
    end

    test "contains the specified number of words" do
      words = Exfake.sentence(4) |> String.trim_trailing(".") |> String.split(" ")
      assert length(words) == 4
    end

    test "raises for count <= 1" do
      assert_raise FunctionClauseError, fn -> Exfake.sentence(1) end
    end
  end

  describe "paragraphs/2" do
    test "returns the correct number of sentences" do
      para = Exfake.paragraphs(3)
      # Each sentence ends with ".", split on ". " leaves last with "." attached
      parts = String.split(para, ". ")
      assert length(parts) == 3
    end

    test "raises when limit < 2" do
      assert_raise FunctionClauseError, fn -> Exfake.paragraphs(3, 1) end
    end
  end

  describe "language_code/0" do
    test "returns a 2-letter lowercase code" do
      assert Exfake.language_code() =~ ~r/^[a-z]{2}$/
    end
  end

  describe "company_suffix/0" do
    test "returns one of the known suffixes" do
      assert Exfake.company_suffix() in ["Inc", "and Sons", "LLC", "Group"]
    end
  end

  describe "catch_phrase/0" do
    test "returns a non-empty string" do
      phrase = Exfake.catch_phrase()
      assert is_binary(phrase)
      assert String.length(phrase) > 0
    end
  end

  describe "bs/0" do
    test "returns a non-empty string" do
      bs = Exfake.bs()
      assert is_binary(bs)
      assert String.length(bs) > 0
    end
  end

  describe "company_name/0" do
    test "returns a non-empty string" do
      assert is_binary(Exfake.company_name())
    end
  end

  describe "currency/0" do
    test "returns a list of exactly 3 strings" do
      currency = Exfake.currency()
      assert is_list(currency)
      assert length(currency) == 3
      Enum.each(currency, &assert(is_binary(&1)))
    end
  end

  describe "xss_string/0" do
    test "returns a non-empty string" do
      assert is_binary(Exfake.xss_string())
    end
  end

  describe "xss_file/0" do
    test "returns a non-empty string" do
      assert is_binary(Exfake.xss_file())
    end
  end

  describe "ipv4/0" do
    test "returns 4 dot-separated octets all in 0..255" do
      parts = Exfake.ipv4() |> String.split(".")
      assert length(parts) == 4

      Enum.each(parts, fn p ->
        n = String.to_integer(p)
        assert n >= 0 and n <= 255
      end)
    end

    test "first octet is never zero" do
      Enum.each(1..20, fn _ ->
        first = Exfake.ipv4() |> String.split(".") |> hd()
        assert String.to_integer(first) >= 1
      end)
    end
  end

  describe "ipv6/0" do
    test "returns 8 colon-separated hex groups all in 0..65535" do
      parts = Exfake.ipv6() |> String.split(":")
      assert length(parts) == 8

      Enum.each(parts, fn p ->
        n = String.to_integer(p, 16)
        assert n >= 0 and n <= 65_535
      end)
    end
  end

  describe "mac/0" do
    test "returns 6 colon-separated zero-padded hex octets" do
      parts = Exfake.mac() |> String.split(":")
      assert length(parts) == 6

      Enum.each(parts, fn p ->
        assert String.length(p) == 2
        n = String.to_integer(p, 16)
        assert n >= 0 and n <= 255
      end)
    end
  end

  describe "http_code/0" do
    test "returns an integer in the 1xx–5xx range" do
      code = Exfake.http_code()
      assert is_integer(code)
      assert code >= 100 and code < 600
    end
  end

  describe "http_code/1" do
    test ":info returns a 1xx code" do
      assert Exfake.http_code(:info) in [100, 101, 102, 103]
    end

    test ":success returns a 2xx code" do
      code = Exfake.http_code(:success)
      assert code >= 200 and code < 300
    end

    test ":redirection returns a 3xx code" do
      code = Exfake.http_code(:redirection)
      assert code >= 300 and code < 400
    end

    test ":client_error returns a 4xx code" do
      code = Exfake.http_code(:client_error)
      assert code >= 400 and code < 500
    end

    test ":server_error returns a 5xx code" do
      code = Exfake.http_code(:server_error)
      assert code >= 500 and code < 600
    end
  end

  describe "email/0" do
    test "matches user@domain.tld format" do
      assert Exfake.email() =~ ~r/^[a-z]+@[a-z.]+\.[a-z]+$/
    end
  end

  describe "domain/0" do
    test "starts with www. and contains a TLD" do
      domain = Exfake.domain()
      assert String.starts_with?(domain, "www.")
      assert domain =~ ~r/\.[a-z]+$/
    end
  end

  describe "url/0" do
    test "starts with http:// or https://" do
      url = Exfake.url()
      assert String.starts_with?(url, "http://") or String.starts_with?(url, "https://")
    end
  end

  describe "zip_code/0" do
    test "matches 5-digit or ZIP+4 format" do
      assert Exfake.zip_code() =~ ~r/^\d{5}(-\d{4})?$/
    end
  end
end
