defmodule Datasets.Web do
  @moduledoc """
  Web dataset module.
  """

  @mime_types [
    {"text/html", "html"},
    {"text/plain", "txt"},
    {"text/css", "css"},
    {"text/csv", "csv"},
    {"application/json", "json"},
    {"application/xml", "xml"},
    {"application/pdf", "pdf"},
    {"application/zip", "zip"},
    {"application/octet-stream", "bin"},
    {"image/png", "png"},
    {"image/jpeg", "jpg"},
    {"image/gif", "gif"},
    {"image/svg+xml", "svg"},
    {"image/webp", "webp"},
    {"audio/mpeg", "mp3"},
    {"audio/ogg", "ogg"},
    {"video/mp4", "mp4"},
    {"video/mpeg", "mpeg"},
    {"font/ttf", "ttf"},
    {"font/woff", "woff"}
  ]

  @user_agents [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_4_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_4_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.0.0",
    "Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Mobile/15E148 Safari/604.1",
    "curl/8.7.1"
  ]

  @password_chars String.graphemes(
                    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"
                  )

  @spec mime_types() :: [{String.t(), String.t()}]
  def mime_types(), do: @mime_types

  @spec user_agents() :: [String.t()]
  def user_agents(), do: @user_agents

  @spec password_chars() :: [String.t()]
  def password_chars(), do: @password_chars
end
