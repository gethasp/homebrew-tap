class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.19"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.19/hasp_0.1.19_darwin_arm64.tar.gz"
      sha256 "adba148a9b5867e42893efb9ddaf02ab2d58b7cd5d2ae6a545fe79a1c06ad212"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.19/hasp_0.1.19_darwin_amd64.tar.gz"
      sha256 "243b10b97bc5da1fae7b1c1e6fea8c289f2706149dd564ea4d711694861d891a"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.19/hasp_0.1.19_linux_arm64.tar.gz"
      sha256 "8e64a2c9ed1dfc567ac6f5b2a2e476240b03771c468a52cc409cc60d9c0f6fa1"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.19/hasp_0.1.19_linux_amd64.tar.gz"
      sha256 "9a4b916b40e63dfab7cdf8869ce430903fe9b21f85552944851d498410791739"
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
