class Cld < Formula
  desc "Interactive TUI to browse and resume Claude Code conversations"
  homepage "https://github.com/Leo6Leo/cld"
  url "https://github.com/Leo6Leo/cld/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f897cd5ff8d33af7f4be127dcdb55d38dc23363ff3c403f78f3f5fdbb59ef5c7"
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
