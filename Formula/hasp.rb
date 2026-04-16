class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.5"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.5/hasp_0.1.5_darwin_arm64.tar.gz"
      sha256 "0f6d363b27492274fd94117ca561e48e17b96e72460b898f65a9c78017930377"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.5/hasp_0.1.5_darwin_amd64.tar.gz"
      sha256 "1c06fd0381a673b2bd51c99df3c396c4487e49973ef1c5ee307029e4b385f158"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.5/hasp_0.1.5_linux_arm64.tar.gz"
      sha256 "237f72e12f0ef08cd113947e9100629ff6caad70e860d485d9123c807c13c30c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.5/hasp_0.1.5_linux_amd64.tar.gz"
      sha256 "9ddcd75a8886d85da0dcb2a9b199ccb97bc4e9829f71b8bb4f78e17d5f44c7dc"
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
