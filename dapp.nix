dapp: with dapp; solidityPackage {
  name = "ds-cache";
  deps = with dappsys; [ds-test ds-value];
  src = ./src;
}
