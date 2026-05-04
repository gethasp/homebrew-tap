class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.0"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.0/hasp_1.0.0_darwin_arm64.tar.gz"
      sha256 "f06c06bc2921c4658a5100ca843597b9c8340da65e5ec2595adf5da92d439b65"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.0/hasp_1.0.0_darwin_amd64.tar.gz"
      sha256 "3943be674c493c93f2947a56c27731e1581377d1eaa1d9f26c4131e5a29ab711"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.0/hasp_1.0.0_linux_arm64.tar.gz"
      sha256 "364c22ca0db8a74253f1ded29f04f72bf246ca15166e35c1168c4c831eeb5a67"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.0/hasp_1.0.0_linux_amd64.tar.gz"
      sha256 "5bc98fbbdd79f9c6277631aaba756b5b8238b0f492f371c88f14fc3d18d1a666"
    end
  end
  def install
    libexec.install "bin"
    bin.install_symlink libexec/"bin/hasp"
    (pkgshare/"agent-profiles").install Dir["agent-profiles/*"]
    (pkgshare/"profiles").install Dir["profiles/*"]
    (pkgshare/"scripts").install Dir["scripts/*"]
    pkgshare.install "README.md", "QUICKSTART.md", "OPERATOR_GUIDE.md",
                     "PRODUCTION_GUIDE.md", "RELEASE_MANIFEST", "LICENSE"
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
