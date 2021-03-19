import { filter, sortBy } from 'common/collections';
import { round } from "common/math";
import { Fragment } from "inferno";
import { formatTime } from "../format";
import { useBackend, useLocalState } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section, Tabs, Collapsible, AnimatedNumber } from "../components";
import { ComplexModal, modalRegisterBodyOverride } from '../interfaces/common/ComplexModal';
import { Window } from "../layouts";
import { flow } from 'common/fp';

const viewCrateContents = (modal, context) => {
  const { act, data } = useBackend(context);
  const {
    supply_points,
  } = data;
  const {
    name,
    cost,
    manifest,
    ref,
    random,
  } = modal.args;
  return (
    <Section
      width="400px"
      level={2}
      m="-1rem"
      pb="1rem"
      title={name}
      buttons={
        <Button
          icon="shopping-cart"
          content={"Buy - " + cost + " points"}
          disabled={cost > supply_points}
          onClick={() => act("request_crate", { ref: ref })} />
      }>
      <Section title={"Contains" + (random ? (" any " + random + " of:") : "")} scrollable height="200px">
        {manifest.map(m => (
          <Box key={m}>
            {m}
          </Box>
        ))}
      </Section>
    </Section>
  );
};

export const SupplyConsole = (props, context) => {
  const { act, data } = useBackend(context);
  modalRegisterBodyOverride("view_crate", viewCrateContents);
  return (
    <Window width={700} height={620}>
      <Window.Content>
        <ComplexModal maxWidth="100%" />
        <Section title="Записи поставок">
          <SupplyConsoleShuttleStatus />
          <SupplyConsoleMenu />
        </Section>
      </Window.Content>
    </Window>
  );
};

const SupplyConsoleShuttleStatus = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    supply_points,
    shuttle,
    shuttle_auth,
  } = data;

  let shuttle_buttons = null;
  let showShuttleForce = false;

  if (shuttle_auth) {
    if (shuttle.launch === 1 && shuttle.mode === 0) {
      shuttle_buttons = (
        <Button
          icon="rocket"
          content="Send Away"
          onClick={() => act("send_shuttle", { mode: "send_away" })} />
      );
    } else if (shuttle.launch === 2 && (shuttle.mode === 3 || shuttle.mode === 1)) {
      shuttle_buttons = (
        <Button
          icon="ban"
          content="Отменить запуск"
          onClick={() => act("send_shuttle", { mode: "cancel_shuttle" })} />
      );
    } else if (shuttle.launch === 1 && shuttle.mode === 5) {
      shuttle_buttons = (
        <Button
          icon="rocket"
          content="Отправить шаттл"
          onClick={() => act("send_shuttle", { mode: "send_to_station" })} />
      );
    }
    if (shuttle.force) {
      showShuttleForce = true;
    }
  }

  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Очки поставок">
          <AnimatedNumber value={supply_points} />
        </LabeledList.Item>
      </LabeledList>
      <Section level={2} title="Шаттл поставок" mt={2}>
        <LabeledList>
          <LabeledList.Item label="Положение" buttons={(
            <Fragment>
              {shuttle_buttons}
              {showShuttleForce ? (
                <Button
                  icon="exclamation-triangle"
                  content="Принудительный запуск"
                  onClick={() => act("send_shuttle", { mode: "force_shuttle" })} />
              ) : null}
            </Fragment>
          )}>
            {shuttle.location}
          </LabeledList.Item>
          <LabeledList.Item label="Двигатели">
            {shuttle.engine}
          </LabeledList.Item>
          {shuttle.mode === 4 ? (
            <LabeledList.Item label="Время прибытия">
              {(shuttle.time > 1) ? formatTime(shuttle.time) : "LATE"}
            </LabeledList.Item>
          ) : null}
        </LabeledList>
      </Section>
    </Section>
  );
};

const SupplyConsoleMenu = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    order_auth,
  } = data;

  const [tabIndex, setTabIndex] = useLocalState(context, "tabIndex", 0);

  return (
    <Section title="Меню">
      <Tabs>
        <Tabs.Tab
          icon="box"
          selected={tabIndex === 0}
          onClick={() => setTabIndex(0)}>
          Запрос
        </Tabs.Tab>
        <Tabs.Tab
          icon="check-circle-o"
          selected={tabIndex === 1}
          onClick={() => setTabIndex(1)}>
          Одобрено
        </Tabs.Tab>
        <Tabs.Tab
          icon="circle-o"
          selected={tabIndex === 2}
          onClick={() => setTabIndex(2)}>
          Запросы
        </Tabs.Tab>
        <Tabs.Tab
          icon="book"
          selected={tabIndex === 3}
          onClick={() => setTabIndex(3)}>
          История заказов
        </Tabs.Tab>
        <Tabs.Tab
          icon="book"
          selected={tabIndex === 4}
          onClick={() => setTabIndex(4)}>
          История экспорта
        </Tabs.Tab>
      </Tabs>
      {tabIndex === 0 ? <SupplyConsoleMenuOrder /> : null}
      {tabIndex === 1 ? <SupplyConsoleMenuOrderList mode="Approved" /> : null}
      {tabIndex === 2 ? <SupplyConsoleMenuOrderList mode="Requested" /> : null}
      {tabIndex === 3 ? <SupplyConsoleMenuOrderList mode="All" /> : null}
      {tabIndex === 4 ? <SupplyConsoleMenuHistoryExport /> : null}
    </Section>
  );
};

const SupplyConsoleMenuOrder = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    categories,
    supply_packs,
    contraband,
    supply_points,
  } = data;

  const [activeCategory, setActiveCategory] = useLocalState(context, "activeCategory", null);

  const viewingPacks = flow([
    filter(val => val.group === activeCategory),
    filter(val => !val.contraband || contraband),
    sortBy(val => val.name),
    sortBy(val => (val.cost > supply_points)),
  ])(supply_packs);

  // const viewingPacks = sortBy(val => val.name)(supply_packs).filter(val => val.group === activeCategory);

  return (
    <Section level={2}>
      <Flex spacing={1}>
        <Flex.Item basis="25%">
          <Section title="Категории" scrollable fill height="290px">
            {categories.map(category => (
              <Button
                key={category}
                fluid
                content={category}
                selected={category === activeCategory}
                onClick={() => setActiveCategory(category)} />
            ))}
          </Section>
        </Flex.Item>
        <Flex.Item grow={1}>
          <Section title="Содержимое" scrollable fill height="290px">
            {viewingPacks.map(pack => (
              <Box key={pack.name}>
                <Flex align="center" justify="flex-start" spacing={1}>
                  <Flex.Item basis="70%">
                    <Button
                      fluid
                      icon="shopping-cart"
                      ellipsis
                      content={pack.name}
                      color={(pack.cost > supply_points) ? "red" : null}
                      onClick={() => act("request_crate", { ref: pack.ref })} />
                  </Flex.Item>
                  <Flex.Item>
                    <Button
                      content="#"
                      color={(pack.cost > supply_points) ? "red" : null}
                      onClick={() => act("request_crate_multi", { ref: pack.ref })} />
                  </Flex.Item>
                  <Flex.Item>
                    <Button
                      content="C"
                      color={(pack.cost > supply_points) ? "red" : null}
                      onClick={() => act("view_crate", { crate: pack.ref })} />
                  </Flex.Item>
                  <Flex.Item grow={1}>
                    {pack.cost} points
                  </Flex.Item>
                </Flex>
              </Box>
            ))}
            {/* Alternative collapsible style folders */}
            {/* {viewingPacks.map(pack => (
              <Collapsible title={pack.name} mb={-0.7}>
                <center>
                  {pack.manifest.map(item => (
                    <Box mb={0.5}>
                      {item}
                    </Box>
                  ))}
                  <Button
                    fluid
                    color="green"
                    content={"Buy - " + pack.cost + " points"} />
                </center>
              </Collapsible>
            ))} */}
          </Section>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const SupplyConsoleMenuOrderList = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    mode,
  } = props;
  const {
    orders,
    order_auth,
    supply_points,
  } = data;

  const displayedOrders = orders.filter(val => (val.status === mode || mode === "All"));

  if (!displayedOrders.length) {
    return (
      <Section level={2}>
        Заказов нет.
      </Section>
    );
  }

  return (
    <Section level={2}>
      {(mode === "Requested" && order_auth) ? (
        <Button
          mt={-1}
          mb={1}
          fluid
          color="red"
          icon="trash"
          content="Удалить все запросы"
          onClick={() => act("clear_all_requests")} />
      ) : null}
      {displayedOrders.map((order, i) => (
        <Section title={"Заказ " + (i + 1)} key={i} buttons={(mode === "All" && order_auth) ? (
          <Button
            color="red"
            icon="trash"
            content="Удалить запись"
            onClick={() => act("delete_order", { ref: order.ref })} />
        ) : null}>
          <LabeledList>
            {order.entries.map(field => field.entry ? (
              <LabeledList.Item label={field.field} buttons={order_auth ? (
                <Button
                  icon="pen"
                  content="Изм."
                  onClick={() => {
                    act("edit_order_value", { ref: order.ref, edit: field.field, default: field.entry });
                  }} />
              ) : null}>
                {field.entry}
              </LabeledList.Item>
            ) : null)}
            {mode === "All" ? (
              <LabeledList.Item label="Status">
                {order.status}
              </LabeledList.Item>
            ) : null}
          </LabeledList>
          {order_auth && mode === "Requested" ? (
            <Fragment>
              <Button
                icon="check"
                content="Одобрить"
                disabled={order.cost > supply_points}
                onClick={() => act("approve_order", { ref: order.ref })} />
              <Button
                icon="times"
                content="Отказ"
                onClick={() => act("deny_order", { ref: order.ref })} />
            </Fragment>
          ) : null}
        </Section>
      ))}
    </Section>
  );
};

const SupplyConsoleMenuHistoryExport = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    receipts,
    order_auth,
  } = data;

  if (!receipts.length) {
    return (
      <Section level={2}>
        No receipts found.
      </Section>
    );
  }

  return (
    <Section level={2}>
      {receipts.map((r, ri) => (
        <Section key={ri}>
          <LabeledList>
            {r.title.map(title => (
              <LabeledList.Item label={title.field} key={title.field} buttons={order_auth ? (
                <Button
                  icon="pen"
                  content="Изм."
                  onClick={() => act("export_edit", { ref: r.ref, edit: title.field, default: title.entry })} />
              ) : null}>
                {title.entry}
              </LabeledList.Item>
            ))}
            {r.error ? (
              <LabeledList.Item labelColor="red" label="Error">
                {r.error}
              </LabeledList.Item>
            ) : r.contents.map((item, i) => (
              <LabeledList.Item label={item.object} key={i} buttons={order_auth ? (
                <Fragment>
                  <Button
                    icon="pen"
                    content="Изм."
                    onClick={() => act("export_edit_field", {
                      ref: r.ref,
                      index: i + 1,
                      edit: "meow",
                      default: item.object,
                    })} />
                  <Button
                    icon="trash"
                    color="red"
                    content="Удалить"
                    onClick={() => act("export_delete_field", {
                      ref: r.ref,
                      index: i + 1,
                    })} />
                </Fragment>
              ) : null}>
                {item.quantity}x -&gt; {item.value} points
              </LabeledList.Item>
            ))}
          </LabeledList>
          {order_auth ? (
            <Fragment>
              <Button
                mt={1}
                icon="plus"
                content="Добавить предмет"
                onClick={() => act("export_add_field", { ref: r.ref })} />
              <Button
                icon="trash"
                content="Удалить запись"
                onClick={() => act("export_delete", { ref: r.ref })} />
            </Fragment>
          ) : null}
        </Section>
      ))}
    </Section>
  );
};