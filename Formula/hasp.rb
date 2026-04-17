class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.14"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.14/hasp_0.1.14_darwin_arm64.tar.gz"
      sha256 "ce467d45ca55b8f98011ea26e0c994f43b260fed5b51f73e77bd07f804a21132"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.14/hasp_0.1.14_darwin_amd64.tar.gz"
      sha256 "19b9e698bfa0ef688b42a483774a9a4c6e09f933cb2a03422a42dbdf99bd8bee"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.14/hasp_0.1.14_linux_arm64.tar.gz"
      sha256 "5558f613f069ad5854eadc37e163bed66145cbb7707b0039e9fcc397083d7bfb"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.14/hasp_0.1.14_linux_amd64.tar.gz"
      sha256 "51878d15fcfd9221240ab0b3780bfdcc9ad8256c7cd5bd48c8a1c1ceab075a4a"
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
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
