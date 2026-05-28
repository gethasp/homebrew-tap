class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.31"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.31/hasp_1.0.31_darwin_arm64.tar.gz"
      sha256 "8d61fb4d61daea3e9c50d4ebea3c6281192f98dad46f98d6e01521f06c361e5e"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.31/hasp_1.0.31_darwin_amd64.tar.gz"
      sha256 "5cd1054a4cda67da2aabe8e4679b499657e25a55f63b9c4e9eed41a09d136ac6"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.31/hasp_1.0.31_linux_arm64.tar.gz"
      sha256 "df28edb599497ca6da76e1ad9ef7cfb80fab4fe2901399383afd112102b7986d"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.31/hasp_1.0.31_linux_amd64.tar.gz"
      sha256 "d99136ef674760c20daf276548fdde54f12e068effa8175849080e668e428c0a"
    end
  end
  def install
    libexec.install "bin"
    bin.install_symlink libexec/"bin/hasp"
    (pkgshare/"agent-profiles").install Dir["agent-profiles/*"]
    (pkgshare/"profiles").install Dir["profiles/*"]
    (pkgshare/"scripts").install Dir["scripts/*"]
    pkgshare.install "README.md", "QUICKSTART.md", "OPERATOR_GUIDE.md", "PRODUCTION_GUIDE.md", "RELEASE_MANIFEST", "LICENSE"
  end

  def caveats
    <<~EOS
      Add #{bin} to PATH if it is not already there.
      Set HASP_HOME and HASP_MASTER_PASSWORD before first use.
      Package docs and helper scripts are installed under: #{pkgshare}
      If hasp version does not print #{version}, run: which -a hasp
      Remove or reorder earlier stale binaries such as ~/.local/bin/hasp, then run: hash -r
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
