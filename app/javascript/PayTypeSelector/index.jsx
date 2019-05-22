import React from 'react'
import NoPayType from './NoPayType'
import CreditCardPayType from './CreditCardPayType'
import CheckPayType from './CheckPayType'
import PurchaseOrderPayType from './PurchaseOrderPayType'

class PayTypeSelector extends React.Component {
  constructor(props) {
    super(props)
    this.onPayTypeSelected = this.onPayTypeSelected.bind(this)
    this.state = {
      payTypeSelected: null
    }
  }

  onPayTypeSelected(event) {
    this.setState({ payTypeSelected: event.target.value })
  }

  render() {
    let PayTypeCustomFields = NoPayType
    if (this.state.payTypeSelected === 'Credit card') {
      PayTypeCustomFields = CreditCardPayType
    } else if (this.state.payTypeSelected === 'Check') {
      PayTypeCustomFields = CheckPayType
    } else if (this.state.payTypeSelected === 'Purchase order') {
      PayTypeCustomFields = PurchaseOrderPayType
    }

    return (
      <div>
        <div>
          <label htmlFor='order_pay_type'>Pay type</label>
          <select id="pay_type" name="order[pay_type]" onChange={this.onPayTypeSelected}>
            <option value="">Select a payment method</option>
            <option value="Check">Check</option>
            <option value="Credit card">Credit card</option>
            <option value="Purchase order">Purchase order</option>
          </select>
        </div>
        <PayTypeCustomFields />
      </div>
    )
  }
}

export default PayTypeSelector
