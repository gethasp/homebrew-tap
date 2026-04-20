class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.27"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.27/hasp_0.1.27_darwin_arm64.tar.gz"
      sha256 "d1b2e9581ed97e762ee9a3d0e04cda73f616ca769afe93a2a4f10c0467714de0"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.27/hasp_0.1.27_darwin_amd64.tar.gz"
      sha256 "65a5cf1268e8ea903c09cc198dd1842056daf51aa6c32d704b88d4a4b90fb482"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.27/hasp_0.1.27_linux_arm64.tar.gz"
      sha256 "ab6802dc6999aef9ca58b799f72ff562a8d6b0f355abbc95cc6eba0788c27124"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.27/hasp_0.1.27_linux_amd64.tar.gz"
      sha256 "b9d6af27a99db6591a0680ed1906b50b6a0114dc94c2e86b003eab7550590ba9"
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
