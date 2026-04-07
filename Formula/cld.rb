class Cld < Formula
  desc "Interactive TUI to browse and resume Claude Code conversations"
  homepage "https://github.com/Leo6Leo/cld"
  url "https://github.com/Leo6Leo/cld/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "9fc4b5e8eecb3a6ac7a444be320e73dc99f494cc201a7fe795ccebff3916efbb"
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
