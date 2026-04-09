class Cld < Formula
  desc "Interactive TUI to browse and resume Claude Code conversations"
  homepage "https://github.com/Leo6Leo/cld"
  url "https://github.com/Leo6Leo/cld/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "3719eea051021b687b829fcf5c9e0b14d126aeb9b4bf7cb223971e8363eaf81d"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "cld"
  end

  def caveats
    <<~EOS
      To enable auto-cd into project directories after resuming,
      add this to your ~/.zshrc:

        cld() {
          local tmpfile=$(mktemp)
          CLAUDE_PROJECTS_CD_FILE="$tmpfile" #{bin}/cld "$@"
          if [[ -s "$tmpfile" ]]; then
            local dir=$(cat "$tmpfile")
            cd "$dir" 2>/dev/null
          fi
          rm -f "$tmpfile"
        }
    EOS
  end

  test do
    assert_match "cld", shell_output("#{bin}/cld --help")
  end
end
