class Cld < Formula
  desc "Interactive TUI to browse and resume Claude Code conversations"
  homepage "https://github.com/Leo6Leo/cld"
  url "https://github.com/Leo6Leo/cld/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
