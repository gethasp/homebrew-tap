class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.42"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.42/hasp_1.0.42_darwin_arm64.tar.gz"
      sha256 "05727ee188b80bce660cd8d24d6e19a17a0201173915f7c86d4fe5d38abe2243"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.42/hasp_1.0.42_darwin_amd64.tar.gz"
      sha256 "452ec431899092dafd097eb87b0bc2e69f6000e6671dcec6188f4a439daba7f4"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.42/hasp_1.0.42_linux_arm64.tar.gz"
      sha256 "ed693720acc65aaf76be6188cfb9631bb3039648ccbfe4b1986249900f667042"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.42/hasp_1.0.42_linux_amd64.tar.gz"
      sha256 "352f27ba833060a7311c1ac85af5530a7675fc1ccd726423bc3ae2da333dbb5f"
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
