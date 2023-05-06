# This example uses the pipelines specified in the call.nix file on the
# synthetic data in this directory.
{ bionix ? import <bionix> { } }:

with bionix; let
  R = pkgs.rWrapper.override {packages = with pkgs.rPackages; [scPipe];};
in

let
  stage {
    name = "fastq-reformat";

    input1 = fetchFastQ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/main/Sample_Data/simu_R1.fastq.gz";
        sha256 = "1943w8lb6n0fhkbxzqnpgaa4f12diskvw251567c0y3n5xrw5wd3";
    };

    input2 = fetchFastQ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/main/Sample_Data/simu_R2.fastq.gz";
        sha256 = "159j2da6f6g2kw93rydnd9l1k2zfgmp5sfghix7x3464dx5fwql3";
    };

    buildInputs = [R];

    buildCommand = ''
      mkdir result
      Rscript ${./script.R}
    '';
  }

  # List of input samples
  /*inputs = [
    # Sample 1
    {
      #input1 = fetchFastQ {
      #  url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-1.fq";
      #  sha256 = "0kh29i6fg14dn0fb1xj6pkpk6d83y7zg7aphkbvjrhm82braqkm8";
      #};

      input1 = fetchFastQ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/main/Sample_Data/simu_R1.fastq.gz";
        sha256 = "1943w8lb6n0fhkbxzqnpgaa4f12diskvw251567c0y3n5xrw5wd3";
      };

      #input2 = fetchFastQ {
      #  url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-2.fq";
      #  sha256 = "0czk85km6a91y0fn4b7f9q7ps19b5jf7jzwbly4sgznps7ir2kdk";
      #};

      input2 = fetchFastQ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/main/Sample_Data/simu_R2.fastq.gz";
        sha256 = "159j2da6f6g2kw93rydnd9l1k2zfgmp5sfghix7x3464dx5fwql3";
      };
    }
  ];

in
import ./call.nix { inherit inputs ref bionix; }/*