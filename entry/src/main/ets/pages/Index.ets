@Entry
@Component
struct Index {
  @State progressValue: number = 0
  @State cumulativeDegree: number = 0;
  threshold: number = 10;

  build() {
    Column() {
      Counter() {
        Text(this.progressValue.toString())
      }
      .margin(40)
      .onInc(() => {
        this.progressValue++
      })
      .onDec(() => {
        this.progressValue--
      })
    }
    .focusable(true)
    .focusOnTouch(true)
    .defaultFocus(true)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onDigitalCrown((event: CrownEvent) => {
      event.stopPropagation();
      console.debug('action:%d, angularVelocity:%f, degree:%f, timestamp:%f',
        event.action, event.angularVelocity, event.degree, event.timestamp);
      this.cumulativeDegree += event.degree;

      if (Math.abs(this.cumulativeDegree) >= this.threshold) {
        if (this.cumulativeDegree > 0) {
          console.info('crown - Prev')
          this.progressValue -= 1
        } else {
          console.info('crown - Next')
          this.progressValue += 1
        }
        this.cumulativeDegree = 0;
      }
    })
  }
}