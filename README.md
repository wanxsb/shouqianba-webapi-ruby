# Shouqianba::Webapi

该Gem包主要面向收钱吧支付平台文档(https://www.gitbook.com/book/wosai/shouqianba-doc) 进行开发，服务由收钱吧提供

## Installation

将以下粘贴至项目的Gemfile

```ruby
gem 'shouqianba-webapi-ruby'
```

然后:

    $ bundle

或者手动:

    $ gem install shouqianba-webapi-ruby

## Usage

激活终端并获取终端信息：activate
```
  Shouqianba::Webapi.activate(vendor_sn, vendor_key, app_id, code, device_id, options={}) do |resp|
    # 处理终端返回信息
  end
```

终端签到并获取新的终端key：checkin
```
  Shouqianba::Webapi.checkin(vendor_sn, vendor_key, terminal_sn, device_id, options={}) do |resp|
    # 处理终端返回信息
  end
```

付款接口：pay
```
  Shouqianba::Webapi.pay(vendor_sn, vendor_key, terminal_sn, client_sn, total_amount, dynamic_id, subject, operator, options={}) do |resp|
    # 处理终端返回信息
  end
```

预下单接口：precreate
```
  Shouqianba::Webapi.precreate(vendor_sn, vendor_key, terminal_sn, client_sn, total_amount, payway, subject, operator, options={}) do |resp|
    # 处理终端返回信息
  end
```

退款接口：refund
```
  Shouqianba::Webapi.refund(vendor_sn, vendor_key, terminal_sn, refund_request_no, options={}) do |resp|
    # 处理终端返回信息
  end
```

撤单接口：cancel
```
  Shouqianba::Webapi.cancel(vendor_sn, vendor_key, terminal_sn, device_id, options={}) do |resp|
    # 处理终端返回信息
  end
```

查询接口：query
```
  Shouqianba::Webapi.query(vendor_sn, vendor_key, terminal_sn, options={}) do |resp|
    # 处理终端返回信息
  end
```

## Development



## Contributing

有任何疑问，请联系 wanxsb@gmail.com