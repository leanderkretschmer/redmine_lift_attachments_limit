// Lift Attachments Limit Plugin - Enhanced addFile function
// This wraps the original addFile function to add upload limit functionality

(function() {
  'use strict';
  
  // Function to enhance the addFile function
  function enhanceAddFile() {
    if (typeof window.addFile !== 'undefined' && !window.addFile.enhanced) {
      // Store the original function
      var originalAddFile = window.addFile;
      
      // Replace with our enhanced version
      window.addFile = function(inputEl, file, eagerUpload) {
        // Check if maxFileUploads is set
        if (typeof window.maxFileUploads === 'undefined') {
          console.warn('Lift Attachments Limit Plugin: maxFileUploads not set, using default');
          window.maxFileUploads = 10;
        }
        
        // Use jQuery if available (Redmine 6 still uses jQuery)
        if (typeof $ !== 'undefined') {
          var attachmentsFields = $(inputEl).closest('.attachments_form').find('.attachments_fields');
          var maxFiles = ($(inputEl).attr('multiple') == 'multiple' ? window.maxFileUploads : 1);
          
          // Check if we've reached the upload limit
          if (attachmentsFields.children().length >= maxFiles) {
            alert('Maximum number of files (' + maxFiles + ') reached. Please remove some files before adding more.');
            return null;
          }
        } else {
          // Fallback for vanilla JS
          var form = inputEl.closest('.attachments_form');
          if (form) {
            var fields = form.querySelector('.attachments_fields');
            if (fields && fields.children.length >= window.maxFileUploads) {
              alert('Maximum number of files (' + window.maxFileUploads + ') reached. Please remove some files before adding more.');
              return null;
            }
          }
        }
        
        // Call the original function
        return originalAddFile(inputEl, file, eagerUpload);
      };
      
      // Mark as enhanced to prevent double-wrapping
      window.addFile.enhanced = true;
      
      console.log('Lift Attachments Limit Plugin: Enhanced addFile function loaded with limit ' + (window.maxFileUploads || 10));
    } else if (typeof window.addFile === 'undefined') {
      // If addFile is not defined yet, check again in 100ms
      setTimeout(enhanceAddFile, 100);
    }
  }
  
  // Start enhancing when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', enhanceAddFile);
  } else {
    enhanceAddFile();
  }
})();