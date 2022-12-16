#!/bin/bash 

# Subject list 

# !!!!! adjust path!!!! 
#N183 IDs
SUBJECTS="001 002 003 006 007 008 009 010 011 013 014 015 016 017 018 019 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 043 044 045 046 047 049 050 051 052 053 054 056 057 058 059 060 061 063 064 065 066 067 068 069 071 072 073 074 075 076 079 080 081 082 083 084 085 087 090 091 092 093 094 095 096 097 098 099 104 105 106 107 108 109 110 112 113 114 116 117 118 119 120 121 122 123 126 127 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 146 148 149 150 152 153 154 155 156 158 159 160 161 162 163 164 165 168 169 170 172 173 174 176 177 178 179 180 181 183 184 185 186 187 188 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 208 210 211 212 213 214 216 217 219 220"


BASEPATH='BASDIR'

#create and submit job to grid 
for subject in $SUBJECTS; 		
	do
		DATAPATH="${BASEPATH}imaging_files/nback/preproc/C${subject}/"

		cd ${BASEPATH}/imaging_files/nback/preproc/C${subject}/		# job output dir
		
		Input="${DATAPATH}C${subject}_nback_FEAT_detrend_filt.nii.gz"
		Output="${DATAPATH}C${subject}_nback_FEAT_detrend_filt_FIX.nii.gz"
		Melodic="${DATAPATH}FEAT.feat/filtered_func_data.ica/melodic_mix"
		FIXfile="${DATAPATH}FEAT.feat/fix4melview_Training_COBRA_n43_070417_thr60.txt"
		HANDfile="${DATAPATH}FEAT.feat/hand_labels_noise.txt"
		
		if [ -f $FIXfile ]; then
			
			cat ${DATAPATH}FEAT.feat/fix4melview_Training_COBRA_n43_070417_thr60.txt | tail -1  > tmp${subject}
			Rejected=$(cat tmp${subject})
			rm tmp${subject}
			
		elif [ -f $HANDfile ]; then
			
			Rejected=$(cat ${DATAPATH}FEAT.feat/hand_labels_noise.txt)
		
		else echo "reject comps txt not found: C${subject}"
		fi
		
															
   	  	fsl_regfilt -i ${Input} -o ${Output} -d ${Melodic} -f \"${Rejected}\"
		

done
