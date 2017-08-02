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
  Shouqianba::Webapi.checkin(terminal_sn, terminal_key, device_id, options={}) do |resp|
    # 处理终端返回信息
  end
```

付款接口：pay
```
  Shouqianba::Webapi.pay(terminal_sn, terminal_key, client_sn, total_amount, dynamic_id, subject, operator, options={}) do |resp|
    # 处理终端返回信息
  end
```

预下单接口：precreate
```
  Shouqianba::Webapi.precreate(terminal_sn, terminal_key, client_sn, total_amount, payway, subject, operator, options={}) do |resp|
    # 处理终端返回信息
  end
```

退款接口：refund
```
  Shouqianba::Webapi.refund(terminal_sn, terminal_key, refund_request_no, operator, refund_amount, options={}) do |resp|
    # 处理终端返回信息
  end
```

撤单接口：cancel
```
  Shouqianba::Webapi.cancel(terminal_sn, terminal_key, options={}) do |resp|
    # 处理终端返回信息
  end
```

查询接口：query
```
  Shouqianba::Webapi.query(terminal_sn, terminal_key, options={}) do |resp|
    # 处理终端返回信息
  end
```

查询接口：wap2_url
```
  Shouqianba::Webapi.wap2_url(terminal_sn, client_sn, total_amount, subject, operator, return_url, options={}) do |resp|
    # 处理终端返回跳转链接地址
  end
```

## Development



## Contributing

有任何疑问，请联系 wanxsb@gmail.com