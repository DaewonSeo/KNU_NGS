#!/bin/bash

# [ Author : Daewonseo]
# Date : 2022. 9. 13. 
#          Description
#
#          This is the preprocessing program for fastq data file.
#
# ------------------------------------------------------------------


rename_file(){
        echo "입력 파일이 위치한 폴더명을 입력하세요: "
        read input_directory_name
        echo "출력 파일이 저장될 폴더명을 입력하세요: "
        read output_directory_name
        echo "변환에 사용될 문자열을 입력하세요: "
        read STR
        if [ -d "$output_directory_name" ]; then
            echo "이미 폴더가 존재하므로 새로 생성하지 않습니다."
        else
            mkdir $output_directory_name
        fi
        samples=$(ls ${input_directory_name})
        for s in $samples;
        do
                serviceNum=${s:0:14}
                reservNum=${s:15:11}
                restNum=${s:27}
                cp "${input_directory_name}/${s}" "${output_directory_name}/${serviceNum}${STR}${reservNum}${STR}${restNum}"
                echo "$restNum 변환 완료"
        done
}

merge_fastq(){
        echo "입력 파일이 위치한 폴더명을 입력하세요: "
        read input_directory_name
        echo "출력 파일이 저장될 폴더명을 입력하세요: "
        read output_directory_name
        if [ -d "$output_directory_name" ]; then
            echo "이미 폴더가 존재하므로 새로 생성하지 않습니다."
        else
            mkdir $output_directory_name
        fi

        mergeSamples=$(ls ${input_directory_name} | cut -d '_' -f 1-4 | uniq | sort)

        for m in $mergeSamples;
        do
                echo "$m 생성 완료"
                targetNum=$(ls ${input_directory_name}/${m}*)
                cat ${targetNum} > ${output_directory_name}/${m}.fastq.gz
        done                

}

echo "###########################################################"                                                   
echo "                                                           "                                                         
echo "    [[   Fastq 데이터 전처리 프로그램   ]]                       "
echo "                                                           "                                                            
echo "                                                           "                                                            
echo "   - 데이터 파일명 변경                                    "   
echo "   - 데이터 결과 파일 병합                                 "   
echo "   * 프로그램을 강제 종료하시려면 ctrl + c 혹은 command + c    "  
echo "                                                           "
echo "###########################################################"   
echo ""
echo ""
echo "이용하실 서비스 번호를 선택하세요 : "
echo "1. 데이터 파일명 변경"
echo "2. 데이터 결과 파일 병합"
read selectionNum
echo ""
echo ""
echo "###########################################################"
echo "${selectionNum}번 서비스를 선택했습니다."
echo "###########################################################"
echo ""
echo ""
if [[ $selectionNum -eq 1 ]]
then
        echo "###########################################################"
        echo "데이터 파일명 변경 서비스를 시작합니다."
        echo "###########################################################"
        echo ""
        echo""
        rename_file

elif [[ $selectionNum -eq 2 ]]
then
        echo "###########################################################"
        echo "데이터 결과 파일 병합 서비스를 시작합니다."
        echo "###########################################################"
        echo ""
        echo "" 
        merge_fastq
else
        echo "###########################################################"
        echo "올바르지 않은 서비스 번호를 선택했습니다."
        echo "###########################################################"
fi