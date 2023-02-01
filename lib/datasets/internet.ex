defmodule Datasets.Internet do
  @moduledoc """
  Internet dataset module.
  """
  @spec suffixes :: [String.t(), ...]
  def suffixes do
    [
      "gov",
      "edu",
      "com",
      "org",
      "net",
      "au",
      "in",
      "me",
      "biz",
      "br",
      "it",
      "ca",
      "mx",
      "tw"
    ]
  end

  @spec free_domains :: [String.t(), ...]
  def free_domains do
    ["gmail.com", "yahoo.com", "hotmail.com"]
  end
end
