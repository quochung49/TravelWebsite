
function addToCart(bookId) {
    // Create a URL to your servlet with the bookId as a parameter
    var url = 'addcart?bookId=' + bookId;

    // Make an AJAX request to the servlet
    fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(data => {
                // Handle the response here if needed
                const parser = new DOMParser();
                const doc = parser.parseFromString(data, 'text/html');
                var count = doc.querySelector('#cart-item-count');
                var newCount = document.querySelector('#cart-item-count');
                newCount.innerHTML = count.innerHTML;
                console.log(count);
                // Show the modal when the item is added to the cart
                $('#addToCartModal').modal('show');

                // Update the cart item count using another AJAX request
            })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
}


function updateItemQuantity(inputElement, bookId) {
    var quantityInput = inputElement;
    var newQuantity = quantityInput.value;
    // Create a URL to your servlet with the parameters
    var url = '../updateItem?bookId=' + bookId + '&quantity=' + newQuantity;
    // Make an AJAX request to the servlet
    fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                // Handle the response here if needed

                return response.text();
            })
            .then(data => {
                if (newQuantity === '0') {
                    // If the new quantity is 0, remove the row from the table
                    var row = inputElement.closest('tr');
                    if (row) {
                        row.remove();
                    }
                } else
                {
                    // Handle a successful responseconst 
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(data, 'text/html');
                    var total = doc.querySelector('#total-' + bookId);

                    var totalElement = document.querySelector('#total-' + bookId);
                    totalElement.innerHTML = total.innerHTML;
                }

            })
            .catch(error => {
                var modal = new bootstrap.Modal(document.getElementById('outOfStockModal'));
                modal.show();
            });
}


function removeItem(inputElement, bookId) {
    // Create a URL to your servlet with the parameters
    var url = '../removeItem?bookId=' + bookId;
    // Make an AJAX request to the servlet
    fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                // Handle the response here if needed
                return response.text();
            })
            .then(data => {
                console.log(data);
                var row = inputElement.closest('tr');
                if (row) {
                    row.remove();
                }
            })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
}



