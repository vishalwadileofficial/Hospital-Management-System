/**
 * Hospital Management System - JavaScript
 * Common functions and utilities
 */

// Wait for DOM to load
document.addEventListener('DOMContentLoaded', function() {
    console.log('Hospital Management System loaded');
    
    // Initialize components
    initializeNavbar();
    initializeForms();
    initializeAnimations();
});

/**
 * Navbar functionality
 */
function initializeNavbar() {
    // Mobile menu toggle (for responsive design)
    const navbar = document.querySelector('.navbar');
    
    // Sticky navbar on scroll
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
        } else {
            navbar.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
        }
    });
}

/**
 * Form validation and enhancement
 */
function initializeForms() {
    // Add validation styling to all forms
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        // Add submit event listener
        form.addEventListener('submit', function(e) {
            // Check if form is valid
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                
                // Show validation messages
                showValidationErrors(form);
            }
        });
        
        // Add input event listeners for real-time validation
        const inputs = form.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                validateInput(this);
            });
        });
    });
}

/**
 * Validate individual input
 */
function validateInput(input) {
    if (input.validity.valid) {
        input.style.borderColor = '#28a745';
    } else {
        input.style.borderColor = '#dc3545';
    }
}

/**
 * Show validation errors
 */
function showValidationErrors(form) {
    const inputs = form.querySelectorAll('input:invalid, select:invalid, textarea:invalid');
    
    if (inputs.length > 0) {
        // Focus on first invalid input
        inputs[0].focus();
        
        // Add error styling
        inputs.forEach(input => {
            input.style.borderColor = '#dc3545';
        });
        
        // Show alert
        alert('Please fill in all required fields correctly.');
    }
}

/**
 * Initialize animations
 */
function initializeAnimations() {
    // Fade in cards on scroll
    const cards = document.querySelectorAll('.card, .dept-card, .doctor-card');
    
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '0';
                entry.target.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    entry.target.style.transition = 'all 0.5s ease';
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }, 100);
                
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1
    });
    
    cards.forEach(card => {
        observer.observe(card);
    });
}

/**
 * Confirm action (for deletions, etc.)
 */
function confirmAction(message) {
    return confirm(message || 'Are you sure you want to perform this action?');
}

/**
 * Format phone number (Indian format)
 */
function formatPhoneNumber(input) {
    let value = input.value.replace(/\D/g, '');
    
    if (value.length > 10) {
        value = value.slice(0, 10);
    }
    
    input.value = value;
}

/**
 * Auto-dismiss alerts after 5 seconds
 */
function autoDismissAlerts() {
    const alerts = document.querySelectorAll('.alert');
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s ease';
            alert.style.opacity = '0';
            
            setTimeout(() => {
                alert.remove();
            }, 500);
        }, 5000);
    });
}

// Call auto-dismiss on load
autoDismissAlerts();

/**
 * Smooth scroll to top
 */
function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}

/**
 * Print functionality
 */
function printPage() {
    window.print();
}

/**
 * Export table to CSV (basic implementation)
 */
function exportTableToCSV(tableId, filename) {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    let csv = [];
    const rows = table.querySelectorAll('tr');
    
    rows.forEach(row => {
        let rowData = [];
        const cols = row.querySelectorAll('td, th');
        
        cols.forEach(col => {
            rowData.push(col.innerText);
        });
        
        csv.push(rowData.join(','));
    });
    
    // Download CSV
    const csvContent = csv.join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename || 'export.csv';
    a.click();
    window.URL.revokeObjectURL(url);
}

/**
 * Show loading spinner
 */
function showLoading() {
    const loader = document.createElement('div');
    loader.id = 'loading-spinner';
    loader.innerHTML = '<div class="spinner"></div>';
    loader.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    `;
    
    document.body.appendChild(loader);
}

/**
 * Hide loading spinner
 */
function hideLoading() {
    const loader = document.getElementById('loading-spinner');
    if (loader) {
        loader.remove();
    }
}

/**
 * Copy text to clipboard
 */
function copyToClipboard(text) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    
    // Show success message
    alert('Copied to clipboard!');
}

/**
 * Toggle password visibility
 */
function togglePasswordVisibility(inputId) {
    const input = document.getElementById(inputId);
    if (!input) return;
    
    if (input.type === 'password') {
        input.type = 'text';
    } else {
        input.type = 'password';
    }
}

/**
 * Debounce function (for search, etc.)
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Search/Filter table rows
 */
function filterTable(inputId, tableId) {
    const input = document.getElementById(inputId);
    const table = document.getElementById(tableId);
    
    if (!input || !table) return;
    
    const filter = input.value.toUpperCase();
    const rows = table.getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        let found = false;
        const cells = rows[i].getElementsByTagName('td');
        
        for (let j = 0; j < cells.length; j++) {
            const cell = cells[j];
            if (cell) {
                const text = cell.textContent || cell.innerText;
                if (text.toUpperCase().indexOf(filter) > -1) {
                    found = true;
                    break;
                }
            }
        }
        
        rows[i].style.display = found ? '' : 'none';
    }
}

// Utility: Format date to Indian format
function formatDateIndian(dateString) {
    const date = new Date(dateString);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
}

// Utility: Format currency to Indian Rupees
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-IN', {
        style: 'currency',
        currency: 'INR'
    }).format(amount);
}

console.log('All scripts loaded successfully!');
```

---

## 📚 PART 7: MODULE EXPLANATIONS

Let me explain each part of the system in simple terms:

### **1. MVC Architecture Explanation**

Think of MVC like a restaurant:

- **Model** (Java Classes in `model` package): The recipe/ingredients
  - Stores data structure (User, Doctor, Appointment)
  - Just like a recipe card

- **View** (JSP files): The menu and dining area
  - What customers see
  - Displays information nicely

- **Controller** (Servlets): The waiter
  - Takes orders (user requests)
  - Brings food (processes data)
  - Returns results

**Flow:**
1. User clicks "Login" button (View)
2. LoginServlet receives request (Controller)
3. UserDAO checks database (Model)
4. Result sent back to JSP (View)

---

### **2. Database Flow**

**Registration Flow:**
```
User fills form → RegisterServlet → UserDAO.registerUser() → 
INSERT into database → Success/Error message → Back to user
```

**Login Flow:**
```
User enters credentials → LoginServlet → UserDAO.loginUser() → 
SELECT from database → Create session → Redirect to dashboard
```

**Booking Appointment:**
```
Select doctor → BookAppointmentServlet → Check slot availability → 
INSERT appointment → Confirmation