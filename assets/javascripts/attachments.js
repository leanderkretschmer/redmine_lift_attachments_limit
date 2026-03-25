function addFile(inputEl, file, eagerUpload) {
    const attachmentsFields = inputEl.closest('.attachments_form').querySelector('.attachments_fields');
    const addAttachment = inputEl.closest('.attachments_form').querySelector('.add_attachment');
    const maxFiles = (inputEl.hasAttribute('multiple') ? window.maxFileUploads : 1);

    if (attachmentsFields.children.length < maxFiles) {
        const attachmentId = addFile.nextAttachmentId++;
        const fileSpan = document.createElement('span');
        fileSpan.id = 'attachments_' + attachmentId;
        
        let param = inputEl.dataset.param;
        if (!param) { param = 'attachments'; }

        const filenameInput = document.createElement('input');
        filenameInput.type = 'text';
        filenameInput.className = 'icon icon-attachment filename readonly';
        filenameInput.name = param + '[' + attachmentId + '][filename]';
        filenameInput.readOnly = true;
        filenameInput.value = file.name;

        const descriptionInput = document.createElement('input');
        descriptionInput.type = 'text';
        descriptionInput.className = 'description';
        descriptionInput.name = param + '[' + attachmentId + '][description]';
        descriptionInput.maxLength = 255;
        descriptionInput.placeholder = inputEl.dataset.descriptionPlaceholder;

        const tokenInput = document.createElement('input');
        tokenInput.type = 'hidden';
        tokenInput.className = 'token';
        tokenInput.name = param + '[' + attachmentId + '][token]';

        const removeLink = document.createElement('a');
        removeLink.href = '#';
        removeLink.className = 'icon-only icon-del remove-upload';
        removeLink.innerHTML = '&nbsp;';
        removeLink.addEventListener('click', removeFile);

        fileSpan.appendChild(filenameInput);
        if (!eagerUpload) {
            fileSpan.appendChild(descriptionInput);
        }
        fileSpan.appendChild(tokenInput);
        if (!eagerUpload) {
            fileSpan.appendChild(removeLink);
        }

        if (inputEl.dataset.description === '0') {
            const descInput = fileSpan.querySelector('input.description');
            if (descInput) {
                descInput.remove();
            }
        }

        attachmentsFields.appendChild(fileSpan);

        if (eagerUpload) {
            ajaxUpload(file, attachmentId, fileSpan, inputEl);
        }

        addAttachment.style.display = (attachmentsFields.children.length < maxFiles ? '' : 'none');
        return attachmentId;
    }
    return null;
}

addFile.nextAttachmentId = 1;