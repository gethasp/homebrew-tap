class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.6"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.6/hasp_0.1.6_darwin_arm64.tar.gz"
      sha256 "776b2c236737e65b5bc2fd1d8bb8da338ab948df2105342f5bcd29fd19372c84"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.6/hasp_0.1.6_darwin_amd64.tar.gz"
      sha256 "eb139e020bdcd73c66e175d64e266d7b90376685d73a98b4c3489b9cbb4964ff"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.6/hasp_0.1.6_linux_arm64.tar.gz"
      sha256 "cdeb4f9e3ba25a883d03474241c45d745a9af0cbf4ef070b2ab8c74243687c79"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.6/hasp_0.1.6_linux_amd64.tar.gz"
      sha256 "68083ba71bc5726b5f1991ccc20c63a8d2ec0e53f3439f06fc3a3fbcf227ce9c"
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
