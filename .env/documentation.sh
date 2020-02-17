#!/usr/bin/env bash

documentation_library_import() {
    local _THIS_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P);
    #source "${_THIS_DIR}/../config.sh" &>/dev/null \
    #    || source "./../config.sh" &>/dev/null;
    source "${_THIS_DIR}/basic.sh" &>/dev/null \
        || source "./basic.sh" &>/dev/null;
    #source "${_THIS_DIR}/docker.sh" &>/dev/null \
    #    || source "./docker.sh" &>/dev/null;
    source "${_THIS_DIR}/image.sh" &>/dev/null \
        || source "imagemagick.sh" &>/dev/null;
    source "${_THIS_DIR}/pdf.sh" &>/dev/null \
        || source "./pdf.sh" &>/dev/null;
}
documentation_library_import;

documentation_convert_to_pdfA4_batch() {
    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    local directoryCurrent="$(directory_current)";

    local input="${@}";
    local input=(${input// / });

    local fileInput="${input[0]}";
    local quality="${input[-1]}";

    local densityInput="${input[1]}";
    local densityInput="$([[ "${#densityInput}" -le 0 ]] && echo "600" || echo "${densityInput}")";

    local densityOutput="${input[@]}";
    local densityOutput=(${densityOutput// / });
    unset 'densityOutput[0]';
    unset 'densityOutput[1]';
    unset 'densityOutput[-1]';
    local densityOutput="$(printf "%d " "${densityOutput[@]}")";

    local densityOutput="$(list_clean "${densityOutput}")";
    local densityOutput=(${densityOutput// / });
    local densityOutput="$(printf "%d\n" "${densityOutput[@]}" | sort -rn)";
    local densityOutput=(${densityOutput// / });
    local densityOutput="$(printf "%s " "${densityOutput[@]}")";
    local densityOutput=(${densityOutput// / });

    if [[ -e "${directoryCurrent}/${fileInput}" ]]
    then
        local fileInput="${directoryCurrent}/${fileInput}";
    fi


    local directoryName="$(dirname "${fileInput}" | cut -d. -f1)";
    local fileNamePrefix="$(basename "${fileInput}" | cut -d. -f1)";
    local fileNamePrefix="${directoryName}/${fileNamePrefix}";

    local densityName="$(printf %04d "${densityInput}")";
    local qualityName="$(printf %03d "100")";
    local documentName="${fileInput}";

    local i=0;
    for i in "${!densityOutput[@]}"
    do
    {
        local outputDensity="${densityOutput[i]}";
        local densityName="$(printf %04d "${outputDensity}")";
        local qualityNameJpg="$(printf %03d "100")";
        local qualityNamePdf="$(printf %03d "${quality}")";

        local inputJpg="${documentName}";
        local outputJpg="${fileNamePrefix}_ori-${densityName}-${qualityNameJpg}.jpg";
        local outputPdf="${fileNamePrefix}_ori-${densityName}-${qualityNamePdf}.pdf";
        local size="$(image_A4_sizeMax "${outputDensity}")";

        imagemagick_image_scale "${inputJpg}" "${outputJpg}" "${size}" 100;
        imagemagick_image_convert_to_pdfA4 "${outputJpg}" "${outputPdf}" "${outputDensity}" "${quality}";

        rm "${outputJpg}";
    }
    done


    local directoryName="$(dirname "${fileInput}" | cut -d. -f1)";
    local fileNamePrefix="$(basename "${fileInput}" | cut -d. -f1)";
    local fileNamePrefix="${directoryName}/${fileNamePrefix}";

    local densityName="$(printf %04d "${densityInput}")";
    local qualityName="$(printf %03d "100")";
    local documentName="${fileNamePrefix}_doc-${densityName}-${qualityName}_o.jpg";

    imagemagick_image_optimize_document \
        -density "${densityInput}" \
        "${fileInput}" \
        "${documentName}";

    local i=0;
    for i in "${!densityOutput[@]}"
    do
    {
        local outputDensity="${densityOutput[i]}";
        local densityName="$(printf %04d "${outputDensity}")";
        local qualityNameJpg="$(printf %03d "100")";
        local qualityNamePdf="$(printf %03d "${quality}")";

        local inputJpg="${documentName}";
        local outputJpg="${fileNamePrefix}_doc-${densityName}-${qualityNameJpg}.jpg";
        local outputPdf="${fileNamePrefix}_doc-${densityName}-${qualityNamePdf}.pdf";
        local size="$(image_A4_sizeMax "${outputDensity}")";

        imagemagick_image_scale "${inputJpg}" "${outputJpg}" "${size}" 100;
        imagemagick_image_convert_to_pdfA4 "${outputJpg}" "${outputPdf}" "${outputDensity}" "${quality}";

        rm "${outputJpg}";
    }
    done

    rm "${documentName}";
}
export -f documentation_convert_to_pdfA4_batch;

documentation_convert_batch() {
    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    local input="${@}";
    local input=(${input// / });

    local numbers="";
    local strings="";

    local i=0;
    for i in "${!input[@]}"
    do
    {
        local parameter="${input[i]}";

        if [[ -n ${parameter//[0-9]/} ]]; then
            local strings="${strings} ${parameter}";
        else
            local numbers="${numbers} ${parameter}";
        fi
    }
    done

    local directoryCurrent;
    directoryCurrent="$(directory_current)";

    local numbers=(${numbers// / });
    local strings=(${strings// / });

    local quality=${numbers[-1]};
    local densityInput=${numbers[0]};
    local densityInput="$([[ "${#densityInput}" -le 0 ]] && echo "600" || echo "${densityInput}")";
    local densityOutput="${numbers[@]}";

    local densityOutput=(${densityOutput// / });
    unset 'densityOutput[0]';
    unset 'densityOutput[-1]';
    local densityOutput="$(printf "%d " "${densityOutput[@]}")";

    local densityOutput="$(list_clean "${densityOutput}")";
    local densityOutput=(${densityOutput// / });
    local densityOutput="$(printf "%d\n" "${densityOutput[@]}" | sort -rn)";
    local densityOutput=(${densityOutput// / });
    local densityOutput="$(printf "%s " "${densityOutput[@]}")";
    local densityOutput=(${densityOutput// / });


    local fileOutput=${strings[-1]};
    local filesInput="${strings[@]}";

    local filesInput=(${filesInput// / });
    unset 'filesInput[-1]';
    local filesInput="$(printf "%s " "${filesInput[@]}")";
    local filesInput=(${filesInput// / });


    #echo "quality         " ${quality};
    #echo "densityInput    " ${densityInput};
    #echo "outputDensities " ${densityOutput[@]};
    #echo "numbers         " ${numbers[@]};
    #echo "fileOutput      " ${fileOutput};
    #echo "filesInput      " ${filesInput[@]};
    #echo "strings         " ${strings[@]};
    #return;

    local filesPdf="";

    local i=0;
    for i in "${!filesInput[@]}"
    do
    {
        local file="${filesInput[i]}";

        local outputDensity="${densityInput}";
        local directoryName="$(dirname "${file}" | cut -d. -f1)";
        local fileNamePrefix="$(basename "${file}" | cut -d. -f1)";

        if [[ ${#directoryName} -gt 0 ]]
        then
            local fileNamePrefix="${directoryName}/${fileNamePrefix}";
        fi;

        local inputJpg="${file}";
        local outputJpg="${fileNamePrefix}_o.jpg";
        local outputPdf="${fileNamePrefix}.pdf";
        local size="$(image_A4_sizeMax "${outputDensity}")";

        imagemagick_image_scale "${inputJpg}" "${outputJpg}" "${size}" 100;
        imagemagick_image_convert_to_pdfA4 "${outputJpg}" "${outputPdf}" "${outputDensity}" "${quality}";
        rm "${outputJpg}";

        local filesPdf="${filesPdf} "${outputPdf}"";
    }
    done

    pdf_combine_files "${filesPdf}" "${fileOutput}";
    rm ${filesPdf};


    local i=0;
    for i in "${!filesInput[@]}"
    do
    {
        local file="${filesInput[i]}";

        documentation_convert_to_pdfA4_batch "${file}" "${densityInput}" "${densityOutput[@]}" "${quality}";
    }
    done


    local i=0;
    for i in "${!densityOutput[@]}"
    do
    {
        local outputDensity="${densityOutput[i]}";
        local densityName="$(printf %04d "${outputDensity}")";
        local qualityNamePdf="$(printf %03d "${quality}")";

        local fileList="";

        local j=0;
        for j in "${!filesInput[@]}"
        do
        {
            local file="${filesInput[j]}";

            if [[ -e "${directoryCurrent}/${file}" ]]
            then
                local file="${directoryCurrent}/${file}";
            fi

            local directoryName="$(dirname "${file}" | cut -d. -f1)";
            local fileNamePrefix="$(basename "${file}" | cut -d. -f1)";

            if [[ ${#directoryName} -gt 0 ]]
            then
                local fileNamePrefix="${directoryName}/${fileNamePrefix}";
            fi;

            local pdfFile="${fileNamePrefix}_ori-${densityName}-${qualityNamePdf}.pdf";

            local fileList="${fileList} ${pdfFile}";
        }
        done;


        local directoryName="$(dirname "${fileOutput}" | cut -d. -f1)";
        local fileNamePrefix="$(basename "${fileOutput}" | cut -d. -f1)";

        if [[ ${#directoryName} -gt 0 ]]
        then
            local fileNamePrefix="${directoryName}/${fileNamePrefix}";
        fi;

        local pdfFile="${fileNamePrefix}_ori-${densityName}-${qualityNamePdf}.pdf";

        pdf_combine_files "${fileList}" "${pdfFile}";
        rm ${fileList};
    }
    done;


    local i=0;
    for i in "${!densityOutput[@]}"
    do
    {
        local outputDensity="${densityOutput[i]}";
        local densityName="$(printf %04d "${outputDensity}")";
        local qualityNamePdf="$(printf %03d "${quality}")";

        local fileList="";

        local j=0;
        for j in "${!filesInput[@]}"
        do
        {
            local file="${filesInput[j]}";

            if [[ -e "${directoryCurrent}/${file}" ]]
            then
                local file="${directoryCurrent}/${file}";
            fi

            local directoryName="$(dirname "${file}" | cut -d. -f1)";
            local fileNamePrefix="$(basename "${file}" | cut -d. -f1)";

            if [[ ${#directoryName} -gt 0 ]]
            then
                local fileNamePrefix="${directoryName}/${fileNamePrefix}";
            fi;

            local pdfFile="${fileNamePrefix}_doc-${densityName}-${qualityNamePdf}.pdf";

            local fileList="${fileList} ${pdfFile}";
        }
        done;


        local directoryName="$(dirname "${fileOutput}" | cut -d. -f1)";
        local fileNamePrefix="$(basename "${fileOutput}" | cut -d. -f1)";

        if [[ ${#directoryName} -gt 0 ]]
        then
            local fileNamePrefix="${directoryName}/${fileNamePrefix}";
        fi;

        local pdfFile="${fileNamePrefix}_doc-${densityName}-${qualityNamePdf}.pdf";

        pdf_combine_files "${fileList}" "${pdfFile}";
        rm ${fileList};
    }
    done;

    return;

    echo "quality         " ${quality};
    echo "densityInput    " ${densityInput};
    echo "outputDensities " ${densityOutput[@]};
    echo "numbers         " ${numbers[@]};
    echo "fileOutput      " ${fileOutput};
    echo "filesInput      " ${filesInput[@]};
    echo "strings         " ${strings[@]};
}
export -f documentation_convert_batch;

documentation_convert_batch_directory() {
    local directory="$(directory_current)";
    local files="$( \
        find "${directory}" \
            -mindepth 1 \
            -maxdepth 1 \
            -type "f" \
            -name '1*.tif*' \
            -print \
                | xargs -I% basename % \
                | sort -u \
                | tr '\n' ' ' \
    )" && \
    local files="$( echo -e "${files}" | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )"

    documentation_convert_batch 1200 1200 600 300 150 96 75 72 65 "${files}" "${@}";
}
export -f documentation_convert_batch_directory;

documentation_convert_batch_pdf_directory() {
    local input="${@}";
    local input=(${input// / });

    local i=0;
    for i in "${!input[@]}";
    do
    {
        local timestamp="$(timestamp)";
        local inputPdf="${input[i]}";
        local inputPdfBak="${inputPdf}.bak";

        #timestamp=1000;

        pdf_docker_command pdftk "${inputPdf}" burst output "${timestamp}%06d.pdf";

        local filesSplit="$(documentation_find_batch_files "${timestamp}" "[0-9]+" "pdf")";
        
        local fileSplit;
        for fileSplit in ${filesSplit};
        do
        {
            imagemagick_docker_command \
                convert \
                    -density 1200 \
                    "${fileSplit}" \
                    -quality 100 \
                    "${fileSplit/.pdf/.jpg}";
        }
        done;

        local files="$(documentation_find_batch_files "${timestamp}" "[0-9]+" "jpg")";

        mv -f "${inputPdf}" "${inputPdfBak}";
        
        documentation_convert_batch \
            1200 \
            1200 600 300 150 96 75 72 65 \
            "${files}" \
            "${inputPdf}";
        
        rm -f ${filesSplit};
        rm -f ${files};
        mv -f "${inputPdfBak}" "${inputPdf}";

        echo "";
    }
    done;
}
export -f documentation_convert_batch_pdf_directory;

documentation_clean_batch_directory() {
    local directory="$(directory_current)";
    local files="$( \
        find "${directory}" \
            -mindepth 1 \
            -maxdepth 1 \
            -type "f" \
            -name '1*.tif*' \
            -print \
                | xargs -I% basename % \
                | sort -u \
                | tr '\n' ' ' \
    )" && \
    local files="$( echo -e "${files}" | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )";
    rm ${files};
}
export -f documentation_clean_batch_directory;

documentation_find_batch_files() {
    local input="${@}";
    local input=(${input// / });

    local patternPrefixDefault="[0-9]+";
    local patternSuffixDefault="";
    local fileExtensionDefault="[a-z]+";

    local patternPrefix="$([[ ${#input[@]} -le 2 ]] && echo "" || \
        echo "${input[-3]}")";
    local patternPrefix="$([[ "${#patternPrefix}" -le 0 ]] && echo "${patternPrefixDefault}" || \
        echo "${patternPrefix}")";

    local patternSuffix="$([[ ${#input[@]} -le 1 ]] && echo "" || \
        echo "${input[-2]}")";
    local patternSuffix="$([[ "${#patternSuffix}" -le 0 ]] && echo "${patternSuffixDefault}" || \
        echo "${patternSuffix}")";

    local fileExtension="$([[ ${#input[@]} -le 0 ]] && echo "" || \
        echo "${input[-1]}")";
    local fileExtension="$([[ "${#fileExtension}" -le 0 ]] && echo "${fileExtensionDefault}" || \
        echo "${fileExtension}")";

    local pattern="^./${patternPrefix}${patternSuffix}.${fileExtension}$";

    #echo ${pattern};return;

    local files="$( \
            find "." \
                -mindepth 1 \
                -maxdepth 1 \
                -type "f" \
                -iregex "${pattern}" \
                -print \
                    | xargs -I% basename % \
                    | sort -u \
                    | tr '\n' ' ' \
        )" && \
    local files="$( echo -e "${files}" | \
            sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )";
    echo "${files}";
}
export -f documentation_find_batch_files;

documentation_combine_batch_pdf_directory() {
    local input="${@}";
    local input=(${input// / });

    local outputPrefixDefault="combined";

    local outputPrefix="$([[ ${#input[@]} -le 0 ]] && echo "" || \
        echo "${input[-1]}")";
    local outputPrefix="$([[ "${#outputPrefix}" -le 0 ]] && echo "${outputPrefixDefault}" || \
        echo "${outputPrefix}")";

    local patternPrefix="[0-9]+";
    local fileExtension="pdf";
    local patternSuffixes="";
    local patternSuffixes="${patternSuffixes} _doc-0072-065";
    local patternSuffixes="${patternSuffixes} _doc-0075-065";
    local patternSuffixes="${patternSuffixes} _doc-0096-065";
    local patternSuffixes="${patternSuffixes} _doc-0150-065";
    local patternSuffixes="${patternSuffixes} _doc-0300-065";
    local patternSuffixes="${patternSuffixes} _doc-0600-065";
    local patternSuffixes="${patternSuffixes} _doc-1200-065";
    local patternSuffixes="${patternSuffixes} _ori-0072-065";
    local patternSuffixes="${patternSuffixes} _ori-0075-065";
    local patternSuffixes="${patternSuffixes} _ori-0096-065";
    local patternSuffixes="${patternSuffixes} _ori-0150-065";
    local patternSuffixes="${patternSuffixes} _ori-0300-065";
    local patternSuffixes="${patternSuffixes} _ori-0600-065";
    local patternSuffixes="${patternSuffixes} _ori-1200-065";

    local patternSuffixes=(${patternSuffixes// / });
    local patternSuffixes=("" "${patternSuffixes[@]}");

    local i=0;
    for i in "${!patternSuffixes[@]}"
    do
    {
        local patternSuffix="${patternSuffixes[i]}";
        local files="$(documentation_find_batch_files "${patternPrefix}" "${patternSuffix}" "${fileExtension}")";
        
        local outputFile="${outputPrefix}${patternSuffix}.${fileExtension}";

        pdf_combine_files "${files}" "${outputFile}";
        #echo "";
    }
    done;
}
export -f documentation_combine_batch_pdf_directory;

documentation_move_payment_batch_pdf_directory() {
    local patternPrefix=".+";
    local patternSuffix="payment\_[0-9]+";
    local fileExtension="txt";

    local files="$(documentation_find_batch_files \
            "${patternPrefix}" \
            "${patternSuffix}" \
            "${fileExtension}")";
    local files="$(echo $files | \
            xargs egrep -zoil \
                "buchungstag\:\s*[0-9]+.[0-9]+.[0-9]+\s*" )";
    local files="$( echo -e "${files}" | \
            sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )";

    local file;
    for file in $files;
    do
    {
        local day="$(egrep -zoi "buchungstag\:\s*([0-9]+).([0-9]+).([0-9]+)\s*" "${file}")";
        local day="$(echo "$day" | egrep -zoi "([0-9]+).([0-9]+).([0-9]+)")";
        local day="$(echo "$day" | sed -E 's/([0-9]+).([0-9]+).([0-9]+)/\3-\2-\1/g')";

        local newFile="$(echo "${file}" | sed -E "s/payment/payment_${day}/g")";
        
        mv "${file}" "${newFile}";
        mv "${file/txt/pdf}" "${newFile/txt/pdf}";
    }
    done;
}
export -f documentation_move_payment_batch_pdf_directory;
