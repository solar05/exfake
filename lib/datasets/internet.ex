defmodule Datasets.Internet do
  @moduledoc """
  Internet dataset module.
  """
  @suffixes [
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

  @free_domains ["gmail.com", "yahoo.com", "hotmail.com"]

  @status_codes %{
    info: [100, 101, 102, 103],
    success: [200, 201, 202, 203, 204, 205, 206, 207, 208, 226],
    redirection: [300, 301, 302, 303, 304, 305, 306, 307, 308],
    client_error: [
      400,
      401,
      402,
      403,
      404,
      405,
      406,
      407,
      408,
      409,
      410,
      411,
      412,
      413,
      414,
      415,
      416,
      417,
      418,
      421,
      422,
      423,
      424,
      425,
      426,
      428,
      429,
      431,
      451
    ],
    server_error: [500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511]
  }

  @spec suffixes() :: [String.t(), ...]
  def suffixes() do
    @suffixes
  end

  @spec free_domains() :: [String.t(), ...]
  def free_domains() do
    @free_domains
  end

  def status_codes() do
    @status_codes
  end
end
