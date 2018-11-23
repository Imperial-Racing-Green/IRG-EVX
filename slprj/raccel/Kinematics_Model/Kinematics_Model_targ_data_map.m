  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtP)
    ;%
      section.nData     = 17;
      section.data(17)  = dumData; %prealloc
      
	  ;% rtP.Ramp_InitialOutput
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.Ramp_slope
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.Ramp_start
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.Step_Y0
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.RadtoDeg1_Gain
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.GAIN_Gain
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.GAIN_Gain_pbdfkn5gz3
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.GAIN_Gain_lywuarbb30
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtP.GAIN_Gain_gxcz5voktz
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtP.GAIN_Gain_jvq3gsrwwi
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 9;
	
	  ;% rtP.GAIN_Gain_ctvvappo4m
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 10;
	
	  ;% rtP.GAIN_Gain_bsdtfq1oje
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 11;
	
	  ;% rtP.GAIN_Gain_m2vt0o0ref
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 12;
	
	  ;% rtP.GAIN_Gain_oyqy0mqpvg
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 13;
	
	  ;% rtP.GAIN_Gain_ej1b40oukw
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 14;
	
	  ;% rtP.GAIN_Gain_dntmztrkvr
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 15;
	
	  ;% rtP.GAIN_Gain_lfuqkyc0tg
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 16;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtB)
    ;%
      section.nData     = 24;
      section.data(24)  = dumData; %prealloc
      
	  ;% rtB.gv3giy2db5
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtB.obltvipdot
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtB.j4ni2uuhra
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtB.eiuokjsxp3
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtB.iddoisgbzq
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtB.i2vms01m1k
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 8;
	
	  ;% rtB.fu5va5q0fk
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 54;
	
	  ;% rtB.lm30xe5jws
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 73;
	
	  ;% rtB.dhnxzb0mjy
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 76;
	
	  ;% rtB.hfor1olrf3
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 77;
	
	  ;% rtB.mx4i5itgxl
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 78;
	
	  ;% rtB.lwjktixzcr
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 79;
	
	  ;% rtB.dhtriljxim
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 80;
	
	  ;% rtB.fwm0oglrrd
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 81;
	
	  ;% rtB.b5eq3qyadt
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 82;
	
	  ;% rtB.a3n000o3dc
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 83;
	
	  ;% rtB.nemcj5dj2s
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 84;
	
	  ;% rtB.esthmbhcld
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 85;
	
	  ;% rtB.n3xnawh3kp
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 86;
	
	  ;% rtB.gbcq0debgs
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 87;
	
	  ;% rtB.mlyhvtju52
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 88;
	
	  ;% rtB.nbxx2m2i4y
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 89;
	
	  ;% rtB.l1y0dfbwhu
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 90;
	
	  ;% rtB.jhd0dnnqdb
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 91;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 5;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtDW)
    ;%
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.leypwq55mm
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 19;
      section.data(19)  = dumData; %prealloc
      
	  ;% rtDW.o1x35mltkr
	  section.data(1).logicalSrcIdx = 1;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.cj1ktnc3lk
	  section.data(2).logicalSrcIdx = 2;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.cqqyhb1oov
	  section.data(3).logicalSrcIdx = 3;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.mz1plpr24i
	  section.data(4).logicalSrcIdx = 4;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtDW.a2bgirorsb
	  section.data(5).logicalSrcIdx = 5;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtDW.kcpierl52s
	  section.data(6).logicalSrcIdx = 6;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtDW.kkuw4oox5d
	  section.data(7).logicalSrcIdx = 7;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtDW.la5twx144j
	  section.data(8).logicalSrcIdx = 8;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtDW.bedbs44pc1
	  section.data(9).logicalSrcIdx = 9;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtDW.dllu231oho
	  section.data(10).logicalSrcIdx = 10;
	  section.data(10).dtTransOffset = 9;
	
	  ;% rtDW.fbf1qtaa52
	  section.data(11).logicalSrcIdx = 11;
	  section.data(11).dtTransOffset = 10;
	
	  ;% rtDW.k1hko11ult
	  section.data(12).logicalSrcIdx = 12;
	  section.data(12).dtTransOffset = 11;
	
	  ;% rtDW.ai2nswjotc.LoggedData
	  section.data(13).logicalSrcIdx = 13;
	  section.data(13).dtTransOffset = 12;
	
	  ;% rtDW.czk3aux3gc
	  section.data(14).logicalSrcIdx = 14;
	  section.data(14).dtTransOffset = 17;
	
	  ;% rtDW.dg4jyzaqke
	  section.data(15).logicalSrcIdx = 15;
	  section.data(15).dtTransOffset = 18;
	
	  ;% rtDW.c5qcnswpih
	  section.data(16).logicalSrcIdx = 16;
	  section.data(16).dtTransOffset = 19;
	
	  ;% rtDW.fh2bdrygks
	  section.data(17).logicalSrcIdx = 17;
	  section.data(17).dtTransOffset = 20;
	
	  ;% rtDW.lqchjcnzw3
	  section.data(18).logicalSrcIdx = 18;
	  section.data(18).dtTransOffset = 21;
	
	  ;% rtDW.f1xhgl3hd5
	  section.data(19).logicalSrcIdx = 19;
	  section.data(19).dtTransOffset = 22;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.kppix1b1tk
	  section.data(1).logicalSrcIdx = 20;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.kkswumubfz
	  section.data(1).logicalSrcIdx = 21;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(4) = section;
      clear section
      
      section.nData     = 3;
      section.data(3)  = dumData; %prealloc
      
	  ;% rtDW.ca50zftymv
	  section.data(1).logicalSrcIdx = 22;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.dn3uhriwly
	  section.data(2).logicalSrcIdx = 23;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.jamvm1i2v5
	  section.data(3).logicalSrcIdx = 24;
	  section.data(3).dtTransOffset = 2;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(5) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 3167744575;
  targMap.checksum1 = 4044152898;
  targMap.checksum2 = 1789352682;
  targMap.checksum3 = 1305306456;

