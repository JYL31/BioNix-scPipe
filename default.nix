# This example uses the pipelines specified in the call.nix file on the
# synthetic data in this directory.
{ bionix ? import <bionix> { } }:

with bionix; let
  R = pkgs.rWrapper.override {packages = with pkgs.rPackages; [scPipe];};
in
  stage {
    name = "fastq-reformat";

    input1 = fetchFastQGZ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/41861043ed4646b94d17dce5416c8da971a2077b/Sample_Data/simu_R1.fastq.gz";
        sha256 = "1cspy2f52nbhn1xlkfnrklsv9gw10b0jkzd9r6appl9368j4p6bf";
    };

    input2 = fetchFastQGZ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/41861043ed4646b94d17dce5416c8da971a2077b/Sample_Data/simu_R2.fastq.gz";
        sha256 = "176d7jfxa1p0h0l9g0mmk7r01j9gip903ibwcxlyi2x0ipmhhic9";
    };

    buildInputs = [R];

    buildCommand = ''
      Rscript ${./script.r}
    '';
  }
  